import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/view_models/lead_view_model.dart';
import 'package:lead_manager/views/lead/widgets/build_widgets.dart';
import 'package:lead_manager/views/lead/widgets/course_bottom_sheet.dart';
import 'package:lead_manager/views/lead/widgets/lead_search.dart';
import 'package:lead_manager/views/lead/widgets/single_lead_card.dart';
import 'package:lead_manager/widgets/custom_loader.dart';
import 'package:provider/provider.dart';

class LeadPage extends StatefulWidget {
  const LeadPage({super.key});

  @override
  State<LeadPage> createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  late final PagingController<int, LeadModel> _pagingController;

  @override
  void initState() {
    super.initState();

    final leadProvider = Provider.of<LeadViewModel>(context, listen: false);

    _pagingController = PagingController<int, LeadModel>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => leadProvider.getPaginatedFilteredLeads(pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LeadViewModel>(context, listen: false);

      if (provider.isFiltering) {
        provider.clearFilters();
        _pagingController.refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: const Text(
          "Leads",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: LeadSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Consumer<LeadViewModel>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    buildFilterButton(
                      label: "Select Course",
                      icon: Icons.filter_list,
                      onTap: () async {
                        await provider.getAllCourses();
                        if (provider.getCoursesLoader) {
                          const AppLoadingIndicator();
                        } else {
                          if (!context.mounted) return;

                          final selectedCourse =
                              await showLeadCourseBottomSheet(context);
                          if (selectedCourse != null) {
                            provider.updateFilters(
                                course: selectedCourse.courseId);
                            await provider.fetchAndSetFilteredLeads();
                          }
                        }
                      },
                    ),
                    buildFilterButton(
                        label: "Sort", icon: Icons.sort, onTap: () {}),
                    buildFilterButton(label: "Lead Status", onTap: () {}),
                    buildFilterButton(label: "Lead Source", onTap: () {}),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<LeadViewModel>(
              builder: (context, provider, child) {
                if (provider.isFiltering) {
                  final leads = provider.filteredLeads;
                  if (leads.isEmpty) {
                    return const Center(child: Text("No leads found."));
                  }
                  return ListView.separated(
                    itemCount: leads.length,
                    itemBuilder: (context, index) =>
                        SingleLeadCard(lead: leads[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  );
                } else {
                  return PagingListener(
                    controller: _pagingController,
                    builder: (context, state, fetchNextPage) =>
                        PagedListView<int, LeadModel>.separated(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, item, index) =>
                            SingleLeadCard(lead: item),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

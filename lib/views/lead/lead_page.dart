import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/view_models/lead_view_model.dart';
import 'package:lead_manager/views/lead/widgets/build_widgets.dart';
import 'package:lead_manager/views/lead/widgets/course_bottom_sheet.dart';
import 'package:lead_manager/views/lead/widgets/date_bottom_sheet.dart';
import 'package:lead_manager/views/lead/widgets/lead_search.dart';
import 'package:lead_manager/views/lead/widgets/lead_source_bottom_sheet.dart';
import 'package:lead_manager/views/lead/widgets/single_lead_card.dart';
import 'package:lead_manager/views/lead/widgets/status_bottom_sheet.dart';
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
      fetchPage: (pageKey) =>
          leadProvider.getPaginatedFilteredLeads(pageKey, context),
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
                      isSelected: provider.selectedCourseId != null,
                      onTap: () async {
                        // Show loader while fetching courses
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: AppLoadingIndicator(size: 35),
                          ),
                        );

                        await provider.getAllCourses();

                        // Close the loader
                        if (context.mounted) Navigator.of(context).pop();

                        if (!context.mounted) return;

                        final selectedCourse =
                            await showLeadCourseBottomSheet(context);
                        if (selectedCourse != null) {
                          provider.updateFilters(
                            course: selectedCourse.courseId,
                            status: provider.selectedStatus,
                            source: provider.selectedSource,
                          );
                          if (context.mounted) {
                            await provider.fetchAndSetFilteredLeads(context);
                          }
                        }
                      },
                    ),
                    buildFilterButton(
                      label: "Lead Status",
                      isSelected: provider.selectedStatus != null,
                      onTap: () async {
                        // Show loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: AppLoadingIndicator(size: 35),
                          ),
                        );

                        await provider.getAllStatus();

                        // Dismiss loader
                        if (context.mounted) Navigator.of(context).pop();

                        if (!context.mounted) return;

                        final selectedStatus =
                            await showLeadStatusBottomSheet(context);
                        if (selectedStatus != null) {
                          provider.updateFilters(
                            status: selectedStatus.statusId,
                            course: provider.selectedCourseId,
                            source: provider.selectedSource,
                          );
                          if (context.mounted) {
                            await provider.fetchAndSetFilteredLeads(context);
                          }
                        }
                      },
                    ),
                    buildFilterButton(
                      label: "Lead Source",
                      isSelected: provider.selectedSource != null,
                      onTap: () async {
                        // Show loader
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: AppLoadingIndicator(size: 35),
                          ),
                        );

                        await provider.getAllLeadSource();

                        // Dismiss loader
                        if (context.mounted) Navigator.of(context).pop();

                        if (!context.mounted) return;

                        final selectedSource =
                            await showLeadSourceBottomSheet(context);
                        if (selectedSource != null) {
                          provider.updateFilters(
                            status: provider.selectedStatus,
                            course: provider.selectedCourseId,
                            source: selectedSource.sourceId,
                          );
                          if (context.mounted) {
                            await provider.fetchAndSetFilteredLeads(context);
                          }
                        }
                      },
                    ),
                    buildFilterButton(
                        label: "select Date",
                        onTap: () {
                          showDateBottomSheet(context);
                        }),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<LeadViewModel>(
              builder: (context, provider, child) {
                if (provider.isFiltering) {
                  if (provider.isLoadingFilteredLeads) {
                    return const Center(child: AppLoadingIndicator(size: 35));
                  }

                  final leads = provider.filteredLeads;

                  if (leads.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "No Leads Found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Try adjusting your filters or search again.",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
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
                        newPageProgressIndicatorBuilder: (context) =>
                            const Padding(
                          padding: EdgeInsets.only(bottom: 90, top: 16),
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        newPageErrorIndicatorBuilder: (context) =>
                            const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text('Failed to load more leads'),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

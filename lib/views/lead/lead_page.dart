import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/view_models/lead_view_model.dart';
import 'package:lead_manager/views/lead/widgets/build_widgets.dart';
import 'package:lead_manager/views/lead/widgets/course_bottom_sheet.dart';
import 'package:lead_manager/views/lead/widgets/date_bottom_sheet.dart';
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
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    final leadProvider = Provider.of<LeadViewModel>(context, listen: false);
    _searchController = TextEditingController();

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
    _searchController.dispose();
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
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                shadowColor: Colors.black12,
                child: Consumer<LeadViewModel>(
                  builder: (context, provider, _) {
                    return TextField(
                      controller: _searchController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search leads...',
                        hintStyle: const TextStyle(color: AppColors.grey),
                        prefixIcon:
                            const Icon(Icons.search, color: AppColors.grey),
                        suffixIcon: provider.searchQuery != null &&
                                provider.searchQuery!.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close,
                                    color: AppColors.grey),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  _searchController.clear();

                                  provider.updateFilters(
                                    search: '',
                                    status: provider.selectedStatus,
                                    course: provider.selectedCourseId,
                                    source: provider.selectedSource,
                                    fromDate: provider.selectedFromDate,
                                    toDate: provider.selectedToDate,
                                  );

                                  if (provider.isFiltering) {
                                    await provider
                                        .fetchAndSetFilteredLeads(context);
                                  } else {
                                    _pagingController.refresh();
                                  }
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.primaryColor, width: 1.5),
                        ),
                      ),
                      onChanged: (value) async {
                        provider.updateFilters(
                          search: value,
                          status: provider.selectedStatus,
                          course: provider.selectedCourseId,
                          source: provider.selectedSource,
                          fromDate: provider.selectedFromDate,
                          toDate: provider.selectedToDate,
                        );
                        if (context.mounted) {
                          if (provider.isFiltering) {
                            await provider.fetchAndSetFilteredLeads(context);
                          } else {
                            _pagingController.refresh();
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Consumer<LeadViewModel>(
                builder: (context, provider, child) {
                  return Row(
                    children: [
                      // course--
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
                              fromDate: provider.selectedFromDate,
                              toDate: provider.selectedToDate,
                            );
                            if (context.mounted) {
                              await provider.fetchAndSetFilteredLeads(context);
                            }
                          }
                        },
                      ),

                      // status --
                      buildFilterButton(
                        label: "Lead Status",
                        isSelected: provider.selectedStatus != null,
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: AppLoadingIndicator(size: 35),
                            ),
                          );

                          await provider.getAllStatus();

                          if (context.mounted) Navigator.of(context).pop();

                          if (!context.mounted) return;

                          final selectedStatus =
                              await showLeadStatusBottomSheet(context);
                          provider.updateFilters(
                            status: selectedStatus?.statusId,
                            course: provider.selectedCourseId,
                            source: provider.selectedSource,
                            fromDate: provider.selectedFromDate,
                            toDate: provider.selectedToDate,
                          );
                          if (context.mounted) {
                            await provider.fetchAndSetFilteredLeads(context);
                          }
                        },
                      ),

                      // source --
                      buildFilterButton(
                        label: "Lead Source",
                        isSelected: provider.selectedSource != null,
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: AppLoadingIndicator(size: 35),
                            ),
                          );

                          await provider.getAllLeadSource();

                          if (context.mounted) Navigator.of(context).pop();

                          if (!context.mounted) return;

                          final selectedSource =
                              await showLeadSourceBottomSheet(context);
                          if (selectedSource != null) {
                            provider.updateFilters(
                              status: provider.selectedStatus,
                              course: provider.selectedCourseId,
                              source: selectedSource.sourceId,
                              fromDate: provider.selectedFromDate,
                              toDate: provider.selectedToDate,
                            );
                            if (context.mounted) {
                              await provider.fetchAndSetFilteredLeads(context);
                            }
                          }
                        },
                      ),

                      // date
                      buildFilterButton(
                        label: "select Date",
                        isSelected: provider.selectedFromDate != null,
                        onTap: () async {
                          final result = await showDateBottomSheet(context);
                          if (result != null) {
                            final from = result['from'];
                            final to = result['to'];

                            final formattedFrom =
                                DateFormat('yyyy-MM-dd').format(from!);
                            final formattedTo =
                                DateFormat('yyyy-MM-dd').format(to!);

                            provider.updateFilters(
                              status: provider.selectedStatus,
                              course: provider.selectedCourseId,
                              source: provider.selectedSource,
                              fromDate: formattedFrom,
                              toDate: formattedTo,
                            );
                            if (context.mounted) {
                              await provider.fetchAndSetFilteredLeads(context);
                            }
                          }
                        },
                      ),
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
      ),
    );
  }
}

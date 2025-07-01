import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/models/lead_model.dart';
import 'package:lead_manager/view_models/lead_view_model.dart';
import 'package:lead_manager/views/lead/widgets/build_widgets.dart';
import 'package:lead_manager/views/lead/widgets/lead_search.dart';
import 'package:lead_manager/views/lead/widgets/single_lead_card.dart';
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

    final accessProvider = Provider.of<LeadViewModel>(context, listen: false);

    _pagingController = PagingController<int, LeadModel>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => accessProvider.getAllLeads(pageKey),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
            child: Row(
              children: [
                buildFilterButton(
                  label: "select course",
                  icon: Icons.filter_list,
                  onTap: () {
                    print("haiii");
                  },
                ),
                buildFilterButton(
                    label: "Sort", icon: Icons.sort, onTap: () {}),
                buildFilterButton(label: "Lead Status", onTap: () {}),
                buildFilterButton(label: "Lead Source", onTap: () {}),
              ],
            ),
          ),
          Expanded(
            child: PagingListener(
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
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LeadSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search leads...';

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) {
    // Close search and return query when the user submits
    close(context, query);
    return const SizedBox(); // Return empty widget as this will be handled in LeadPage
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox(); // You can add suggestion logic here if needed
  }
}

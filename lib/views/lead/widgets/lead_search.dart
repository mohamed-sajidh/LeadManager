import 'package:flutter/material.dart';

class LeadSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Return filtered results
    return Center(child: Text("Search result for '$query'"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: Return suggestions
    return Center(child: Text("Suggestions for '$query'"));
  }
}

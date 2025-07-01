// Future<List<LeadModel>> fetchFilteredLeads({
//   int? courseId,
//   String? search,
//   String? status,
//   String? source, // ✅ New optional filter
// }) async {
//   try {
//     final Map<String, String> queryParams = {};

//     if (courseId != null) queryParams['course'] = courseId.toString();
//     if (search != null && search.trim().isNotEmpty) queryParams['search'] = search.trim();
//     if (status != null && status.trim().isNotEmpty) queryParams['status'] = status.trim();
//     if (source != null && source.trim().isNotEmpty) queryParams['source'] = source.trim(); // ✅ Added

//     final uri = Uri.parse('https://your.server.url/api/leads/')
//         .replace(queryParameters: queryParams);

//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       return (jsonData as List).map((e) => LeadModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to fetch leads');
//     }
//   } catch (e) {
//     print("Error fetching leads: $e");
//     rethrow;
//   }
// }

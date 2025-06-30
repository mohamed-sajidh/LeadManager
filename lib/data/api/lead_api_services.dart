import 'package:lead_manager/core/constants/api_constants.dart';
import 'package:lead_manager/core/constants/dio_client.dart';
import 'package:lead_manager/models/lead_details_model.dart';
import 'package:lead_manager/models/lead_model.dart';

class LeadApiServices {
  Future<List<LeadModel>> getLeads(int page) async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get('${ApiConstants.leadEndPoint}?page=$page');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        final List<dynamic> leadJson = jsonData['results'];

        return leadJson.map((item) => LeadModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Leads');
      }
    } catch (e) {
      throw Exception('Error getting Leads: $e');
    }
  }

  Future<LeadDetailsModel> getLeadsById(String userId) async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.leadByIdEndPoint(userId));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        Map<String, dynamic> leadJson = jsonData['lead'];

        LeadDetailsModel singleLead = LeadDetailsModel.fromJson(leadJson);
        return singleLead;
      } else {
        throw Exception('Failed to load Leads By Id');
      }
    } catch (e) {
      throw Exception('Error getting Leads By Id: $e');
    }
  }
}

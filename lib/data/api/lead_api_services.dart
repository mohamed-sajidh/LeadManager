import 'package:lead_manager/core/constants/api_constants.dart';
import 'package:lead_manager/core/constants/dio_client.dart';
import 'package:lead_manager/models/lead_model.dart';

class LeadApiServices {
  Future<LeadModel> getLeads() async {
    try {
      final dio = await DioClient().getAuthorizedDio();

      final response = await dio.get(ApiConstants.leadEndPoint);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        Map<String, dynamic> leadJson = jsonData['results'];

        LeadModel leads = LeadModel.fromJson(leadJson);
        return leads;
      } else {
        throw Exception('Failed to load Leads');
      }
    } catch (e) {
      throw Exception('Error getting Leads: $e');
    }
  }
}

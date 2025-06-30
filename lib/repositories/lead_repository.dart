import 'package:lead_manager/data/api/lead_api_services.dart';
import 'package:lead_manager/models/lead_model.dart';

class LeadRepository {
  final _api = LeadApiServices();

  Future<LeadModel> getLeads() async {
    final response = await _api.getLeads();
    return response;
  }
}

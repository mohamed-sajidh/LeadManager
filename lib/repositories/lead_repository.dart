import 'package:lead_manager/data/api/lead_api_services.dart';
import 'package:lead_manager/models/lead_model.dart';

class LeadRepository {
  final _api = LeadApiServices();

  Future<List<LeadModel>> getLeads(int page) async {
    final response = await _api.getLeads(page);
    return response;
  }
}

class LeadSourceModel {
  String sourceId;
  String sourceLabel;
  String sourceValue;

  LeadSourceModel({
    required this.sourceId,
    required this.sourceLabel,
    required this.sourceValue,
  });

  factory LeadSourceModel.fromJson(Map<String, dynamic> json) {
    return LeadSourceModel(
      sourceId: json['id'] ?? '',
      sourceLabel: json['label'] ?? '',
      sourceValue: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': sourceId,
      'label': sourceLabel,
      'value': sourceValue,
    };
  }
}

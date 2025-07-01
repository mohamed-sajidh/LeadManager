class StatusModel {
  int statusId;
  String statusName;
  String statusValue;

  StatusModel({
    required this.statusId,
    required this.statusName,
    required this.statusValue,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      statusId: json['id'] ?? 0,
      statusName: json['name'] ?? '',
      statusValue: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': statusId,
      'name': statusName,
      'value': statusValue,
    };
  }
}

class ProfileModel {
  int userId;
  String uuId;
  String firstName;
  String emailId;
  String phone;
  String whatsappNumber;
  bool isActive;
  bool isPhoneVerified;
  RoleDetails? roleDetails;

  ProfileModel({
    required this.userId,
    required this.uuId,
    required this.firstName,
    required this.emailId,
    required this.phone,
    required this.whatsappNumber,
    required this.isActive,
    required this.isPhoneVerified,
    this.roleDetails,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['id'] ?? 0,
      uuId: json['uid'] ?? '',
      firstName: json['full_name'] ?? '',
      emailId: json['email'] ?? '',
      phone: json['phone'] ?? '',
      whatsappNumber: json['whatsapp_number'] ?? '',
      isActive: json['is_active'] ?? false,
      isPhoneVerified: json['phone_verified'] ?? false,
      roleDetails: json['role_details'] != null
          ? RoleDetails.fromJson(json['role_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'uid': uuId,
      'full_name': firstName,
      'email': emailId,
      'phone': phone,
      'whatsapp_number': whatsappNumber,
      'is_active': isActive,
      'phone_verified': isPhoneVerified,
      'role_details': roleDetails?.toJson(),
    };
  }
}

class RoleDetails {
  final int id;
  final String label;
  final String value;

  RoleDetails({
    required this.id,
    required this.label,
    required this.value,
  });

  factory RoleDetails.fromJson(Map<String, dynamic> json) {
    return RoleDetails(
      id: json['id'] ?? 0,
      label: json['label'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'value': value,
    };
  }
}

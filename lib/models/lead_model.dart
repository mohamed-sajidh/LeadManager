class LeadModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String whatsappNumber;
  final String email;
  final String city;
  final int followupCount;
  final int pendingFollowup;
  final int completedFollowup;
  final String parentName;
  final String leadSource;
  final LeadSourceDetails leadSourceDetails;
  final LeadStatusDetails leadStatusDetails;
  final CounselorDetails counselorDetails;

  LeadModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.email,
    required this.city,
    required this.followupCount,
    required this.pendingFollowup,
    required this.completedFollowup,
    required this.parentName,
    required this.leadSource,
    required this.leadSourceDetails,
    required this.leadStatusDetails,
    required this.counselorDetails,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      whatsappNumber: json['whatsapp_number'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      followupCount: json['followup_count'] ?? 0,
      pendingFollowup: json['pending_followups'] ?? 0,
      completedFollowup: json['completed_followups'] ?? 0,
      parentName: json['parent_name'] ?? '',
      leadSource: json['lead_source'] ?? '',
      leadSourceDetails: json['lead_source_details'] != null
          ? LeadSourceDetails.fromJson(json['lead_source_details'])
          : LeadSourceDetails.empty(),
      leadStatusDetails: json['lead_status_details'] != null
          ? LeadStatusDetails.fromJson(json['lead_status_details'])
          : LeadStatusDetails.empty(),
      counselorDetails: json['counselor_details'] != null
          ? CounselorDetails.fromJson(json['counselor_details'])
          : CounselorDetails.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
      'email': email,
      'city': city,
      'followup_count': followupCount,
      'pending_followups': pendingFollowup,
      'completed_followups': completedFollowup,
      'parent_name': parentName,
      'lead_source': leadSource,
      'lead_source_details': leadSourceDetails.toJson(),
      'lead_status_details': leadStatusDetails.toJson(),
      'counselor_details': counselorDetails.toJson(),
    };
  }
}

class LeadSourceDetails {
  final String id;
  final DateTime createdAt;
  final bool isEditable;
  final bool isDeletable;
  final bool isDeleted;
  final bool isActive;
  final String label;
  final String value;

  LeadSourceDetails({
    required this.id,
    required this.createdAt,
    required this.isEditable,
    required this.isDeletable,
    required this.isDeleted,
    required this.isActive,
    required this.label,
    required this.value,
  });

  factory LeadSourceDetails.fromJson(Map<String, dynamic> json) {
    return LeadSourceDetails(
      id: json['id'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      isEditable: json['is_editable'] ?? false,
      isDeletable: json['is_deletable'] ?? false,
      isDeleted: json['is_deleted'] ?? false,
      isActive: json['is_active'] ?? false,
      label: json['label'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'is_editable': isEditable,
      'is_deletable': isDeletable,
      'is_deleted': isDeleted,
      'is_active': isActive,
      'label': label,
      'value': value,
    };
  }

  factory LeadSourceDetails.empty() {
    return LeadSourceDetails(
      id: '',
      createdAt: DateTime.now(),
      isEditable: false,
      isDeletable: false,
      isDeleted: false,
      isActive: false,
      label: '',
      value: '',
    );
  }
}

class LeadStatusDetails {
  final int id;
  final String name;
  final String value;
  final String color;
  final bool isActive;
  final bool provideLink;

  LeadStatusDetails({
    required this.id,
    required this.name,
    required this.value,
    required this.color,
    required this.isActive,
    required this.provideLink,
  });

  factory LeadStatusDetails.fromJson(Map<String, dynamic> json) {
    return LeadStatusDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      value: json['value'] ?? '',
      color: json['color'] ?? '',
      isActive: json['is_active'] ?? false,
      provideLink: json['provide_link'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'color': color,
      'is_active': isActive,
      'provide_link': provideLink,
    };
  }

  factory LeadStatusDetails.empty() {
    return LeadStatusDetails(
      id: 0,
      name: '',
      value: '',
      color: '',
      isActive: false,
      provideLink: false,
    );
  }
}

class CounselorDetails {
  final int id;
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String whatsappNumber;
  final bool isActive;

  CounselorDetails({
    required this.id,
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.whatsappNumber,
    required this.isActive,
  });

  factory CounselorDetails.fromJson(Map<String, dynamic> json) {
    return CounselorDetails(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      whatsappNumber: json['whatsapp_number'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'whatsapp_number': whatsappNumber,
      'is_active': isActive,
    };
  }

  factory CounselorDetails.empty() {
    return CounselorDetails(
      id: 0,
      uid: '',
      fullName: '',
      email: '',
      phone: '',
      whatsappNumber: '',
      isActive: false,
    );
  }
}

class LeadModel {
  final String id;
  final LeadStatusDetails leadStatusDetails;
  final LeadSourceDetails leadSourceDetails;
  final UsedFacebookFormDetails usedFacebookFormDetails;
  final CounselorDetailsElement counselorDetails;
  final WebsiteFormDetails websiteFormDetails;
  final dynamic qualificationDetails;
  final dynamic preferredLocationDetails;
  final dynamic courseDetails;
  final dynamic courseModeDetails;
  final int followupCount;
  final int pendingFollowups;
  final int completedFollowups;
  final dynamic lastFollowup;
  final dynamic nextFollowup;
  final String name;
  final String phoneNumber;
  final dynamic whatsappNumber;
  final String email;
  final String city;
  final dynamic reminderDate;
  final bool isArchived;
  final String parentName;
  final dynamic parentPhoneNumber;
  final String leadgenId;
  final int passOutYear;
  final College college;
  final Address address;
  final String howDidYouHearAboutLuminar;
  final String facebookCampaign;
  final DateTime createdAt;
  final bool isEditable;
  final bool isDeletable;
  final bool isDeleted;
  final bool isActive;
  final bool isResubmission;
  final int leadStatus;
  final String leadSource;
  final String usedFacebookForm;
  final int counselor;
  final String websiteForm;
  final dynamic qualification;
  final dynamic preferredLocation;
  final dynamic course;
  final dynamic courseMode;

  LeadModel({
    required this.id,
    required this.leadStatusDetails,
    required this.leadSourceDetails,
    required this.usedFacebookFormDetails,
    required this.counselorDetails,
    required this.websiteFormDetails,
    required this.qualificationDetails,
    required this.preferredLocationDetails,
    required this.courseDetails,
    required this.courseModeDetails,
    required this.followupCount,
    required this.pendingFollowups,
    required this.completedFollowups,
    required this.lastFollowup,
    required this.nextFollowup,
    required this.name,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.email,
    required this.city,
    required this.reminderDate,
    required this.isArchived,
    required this.parentName,
    required this.parentPhoneNumber,
    required this.leadgenId,
    required this.passOutYear,
    required this.college,
    required this.address,
    required this.howDidYouHearAboutLuminar,
    required this.facebookCampaign,
    required this.createdAt,
    required this.isEditable,
    required this.isDeletable,
    required this.isDeleted,
    required this.isActive,
    required this.isResubmission,
    required this.leadStatus,
    required this.leadSource,
    required this.usedFacebookForm,
    required this.counselor,
    required this.websiteForm,
    required this.qualification,
    required this.preferredLocation,
    required this.course,
    required this.courseMode,
  });
}

enum Address {
  EMPTY,
  FORM_BROCHURE_REQUEST_WARNING_NO_EMAIL_PROVIDED,
  FORM_WALKIN_FORM_WARNING_NO_EMAIL_PROVIDED
}

enum College { EMPTY, UNIVERSITY_OF_CALICUT }

class CounselorDetailsElement {
  final int id;
  final String uid;
  final FullName fullName;
  final Email email;
  final String phone;
  final WhatsappNumber whatsappNumber;
  final bool isActive;
  final DateTime createdAt;
  final RoleDetails roleDetails;
  final String profilePic;
  final bool isStaff;
  final bool isSuperuser;

  CounselorDetailsElement({
    required this.id,
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.whatsappNumber,
    required this.isActive,
    required this.createdAt,
    required this.roleDetails,
    required this.profilePic,
    required this.isStaff,
    required this.isSuperuser,
  });
}

enum Email {
  AAMIRNIHAN200_GMAIL_COM,
  JITHIN_GMAIL_COM,
  MIZNAAMEER98_GMAIL_COM,
  SREEJESHAS33_GMAIL_COM,
  TEST3_GMAIL_COM
}

enum FullName { AAMIR_NIHAN_MS, JITHIN, MIZNA_KA, SREEJESH_VS, TEST3 }

class RoleDetails {
  final int id;
  final RoleDetailsLabel label;
  final RoleDetailsValue value;

  RoleDetails({
    required this.id,
    required this.label,
    required this.value,
  });
}

enum RoleDetailsLabel { ADMISSION_COUNSELLOR, SUPER_ADMIN, TEAM_LEAD }

enum RoleDetailsValue { ADMISSION_COUNSELLOR, SUPERADMIN, TEAM_LEAD }

enum WhatsappNumber { EMPTY, THE_918763457886, THE_919747643209 }

class LeadSourceDetails {
  final String id;
  final DateTime createdAt;
  final bool isEditable;
  final bool isDeletable;
  final bool isDeleted;
  final bool isActive;
  final LeadSourceDetailsLabel label;
  final LeadSourceDetailsValue value;

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
}

enum LeadSourceDetailsLabel { FACEBOOK, WEBSITE }

enum LeadSourceDetailsValue { FACEBOOK, WEBSITE }

class LeadStatusDetails {
  final int id;
  final Name name;
  final LeadStatusDetailsValue value;
  final Color color;
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
}

enum Color { THE_0_AE67_F }

enum Name { NEW_LEAD }

enum LeadStatusDetailsValue { NEW_LEAD }

class UsedFacebookFormDetails {
  final String id;
  final String name;
  final String pageId;
  final String formId;
  final String status;
  final DateTime createdAt;
  final bool isEditable;
  final bool isDeletable;
  final bool isDeleted;
  final bool isActive;
  final List<FormField> formFields;
  final List<LastAssignedCounselorElement> counselors;
  final LastAssignedCounselorElement lastAssignedCounselor;

  UsedFacebookFormDetails({
    required this.id,
    required this.name,
    required this.pageId,
    required this.formId,
    required this.status,
    required this.createdAt,
    required this.isEditable,
    required this.isDeletable,
    required this.isDeleted,
    required this.isActive,
    required this.formFields,
    required this.counselors,
    required this.lastAssignedCounselor,
  });
}

class LastAssignedCounselorElement {
  final int id;
  final String fullName;
  final String email;
  final String uid;

  LastAssignedCounselorElement({
    required this.id,
    required this.fullName,
    required this.email,
    required this.uid,
  });
}

class FormField {
  final int id;
  final String facebookFormId;
  final FacebookFormName facebookFormName;
  final String formFieldLabel;
  final String formFieldKey;
  final String formFieldType;
  final String leadFieldMapping;
  final DateTime createdAt;
  final bool isEditable;
  final bool isDeletable;
  final bool isDeleted;
  final bool isActive;

  FormField({
    required this.id,
    required this.facebookFormId,
    required this.facebookFormName,
    required this.formFieldLabel,
    required this.formFieldKey,
    required this.formFieldType,
    required this.leadFieldMapping,
    required this.createdAt,
    required this.isEditable,
    required this.isDeletable,
    required this.isDeleted,
    required this.isActive,
  });
}

enum FacebookFormName { AI_LEADS_FORM_COCHIN }

class WebsiteFormDetails {
  final String id;
  final String name;
  final String formKey;
  final String pageUrl;
  final String description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Tracker tracker;
  final List<CounselorDetailsElement> counselors;

  WebsiteFormDetails({
    required this.id,
    required this.name,
    required this.formKey,
    required this.pageUrl,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.tracker,
    required this.counselors,
  });
}

class Tracker {
  final String id;
  final String formName;
  final dynamic pageUrl;
  final DateTime lastLeadTime;
  final int leadCount;
  final DateTime updatedAt;
  final DateTime createdAt;

  Tracker({
    required this.id,
    required this.formName,
    required this.pageUrl,
    required this.lastLeadTime,
    required this.leadCount,
    required this.updatedAt,
    required this.createdAt,
  });
}

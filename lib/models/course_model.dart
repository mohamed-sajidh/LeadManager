class CourseModel {
  int courseId;
  DateTime createdAt;
  String courseName;

  CourseModel({
    required this.courseId,
    required this.createdAt,
    required this.courseName,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseId: json['id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      courseName: json['course_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': courseId,
      'created_at': createdAt,
      'course_name': courseName,
    };
  }
}

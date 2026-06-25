enum UserRole { student, teacher }

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final UserRole role;
  final String? schoolName;
  final String? gradeLevel;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.schoolName,
    this.gradeLevel,
    this.avatarUrl,
  });

  String get firstName => fullName.split(' ').first;

  UserModel copyWith({
    String? fullName,
    String? email,
    String? schoolName,
    String? gradeLevel,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role,
      schoolName: schoolName ?? this.schoolName,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
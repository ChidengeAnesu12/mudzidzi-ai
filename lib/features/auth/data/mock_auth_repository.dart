import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user_model.dart';

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  @override
  String toString() => message;
}

/// Mock-only auth logic. Swap the method bodies for real HTTP calls later —
/// the method signatures are designed to stay identical.
class MockAuthRepository {
  Future<UserModel> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (email.trim().toLowerCase() == 'demo@mudzidzi.ai' && password == 'password123') {
      return const UserModel(
        id: 'u_001',
        fullName: 'Anesu Moyo',
        email: 'demo@mudzidzi.ai',
        role: UserRole.student,
        schoolName: 'Chisipite High School',
        gradeLevel: 'Form 4 (O-Level)',
      );
    }
    throw const AuthException('Incorrect email or password. Please try again.');
  }

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));
    return UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName,
      email: email,
      role: UserRole.student,
    );
  }

  Future<void> sendPasswordReset({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    // Mock success — no actual email sent.
  }
}

final mockAuthRepositoryProvider = Provider<MockAuthRepository>((ref) {
  return MockAuthRepository();
});
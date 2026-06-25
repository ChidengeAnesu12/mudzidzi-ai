import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/user_model.dart';
import '../../data/mock_auth_repository.dart';

/// Holds the currently authenticated user (null = signed out), wrapped in
/// AsyncValue so screens can react to loading/error states during
/// login/register without separate boolean flags.
class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  AuthController(this._repository) : super(const AsyncValue.data(null));

  final MockAuthRepository _repository;

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.login(email: email, password: password);
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.register(
        fullName: fullName,
        email: email,
        password: password,
      );
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void logout() => state = const AsyncValue.data(null);
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
  return AuthController(ref.watch(mockAuthRepositoryProvider));
});

/// Separate state for Forgot Password — it only needs success/failure,
/// not a User object.
class PasswordResetController extends StateNotifier<AsyncValue<bool>> {
  PasswordResetController(this._repository) : super(const AsyncValue.data(false));

  final MockAuthRepository _repository;

  Future<void> sendResetLink(String email) async {
    state = const AsyncValue.loading();
    try {
      await _repository.sendPasswordReset(email: email);
      state = const AsyncValue.data(true);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final passwordResetControllerProvider =
    StateNotifierProvider<PasswordResetController, AsyncValue<bool>>((ref) {
  return PasswordResetController(ref.watch(mockAuthRepositoryProvider));
});
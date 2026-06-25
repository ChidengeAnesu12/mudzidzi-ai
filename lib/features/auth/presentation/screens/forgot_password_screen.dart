import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(passwordResetControllerProvider.notifier).sendResetLink(_emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    ref.listen(passwordResetControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString()), backgroundColor: AppColors.error),
          );
        },
      );
    });

    final state = ref.watch(passwordResetControllerProvider);
    final isLoading = state.isLoading;
    final isSent = state.valueOrNull == true;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: isSent ? _buildSuccessState(context, textTheme) : _buildFormState(textTheme, isLoading),
        ),
      ),
    );
  }

  Widget _buildFormState(TextTheme textTheme, bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Forgot your password?',
              style: AppTextStyles.displayMedium(color: textTheme.displayMedium?.color)),
          const SizedBox(height: 6),
          Text(
            "Enter your email and we'll send you a link to reset it.",
            style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 28),
          AppTextField(
            controller: _emailController,
            label: 'Email',
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Email is required';
              if (!value.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 28),
          PrimaryButton(label: 'Send Reset Link', isLoading: isLoading, onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.mark_email_read_outlined, size: 64, color: AppColors.success),
          const SizedBox(height: 20),
          Text('Check your email',
              style: AppTextStyles.headlineLarge(color: textTheme.headlineLarge?.color)),
          const SizedBox(height: 8),
          Text(
            'We sent a password reset link to ${_emailController.text.trim()}',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Back to Log In', onPressed: () => context.pop(), fullWidth: false),
        ],
      ),
    );
  }
}
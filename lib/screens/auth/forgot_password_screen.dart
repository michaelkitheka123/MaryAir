import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.sendPasswordResetEmail(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      setState(() {
        _emailSent = true;
      });
    } else {
      _showError(authProvider.errorMessage ?? 'Failed to send reset email');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: AppTheme.spacingS),
                    Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  child: _emailSent ? _buildSuccessView() : _buildFormView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppTheme.spacingXL),

          // Icon
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: AppTheme.cardShadow,
              ),
              child: const Icon(
                Icons.lock_reset,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          // Title
          Text(
            'Reset Password',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Enter your email address and we\'ll send you a link to reset your password',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppTheme.spacingXXL),

          // Email
          CustomTextField(
            label: 'Email Address',
            hint: 'Enter your email',
            controller: _emailController,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: AppTheme.spacingXL),

          // Send button
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return CustomButton(
                text: 'Send Reset Link',
                isLoading: authProvider.isLoading,
                onPressed: _handleResetPassword,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      children: [
        const SizedBox(height: AppTheme.spacingXXL),

        // Success icon
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          decoration: BoxDecoration(
            color: AppTheme.successGreen,
            shape: BoxShape.circle,
            boxShadow: AppTheme.cardShadow,
          ),
          child: const Icon(Icons.check, size: 60, color: Colors.white),
        ),
        const SizedBox(height: AppTheme.spacingXL),

        // Success message
        Text(
          'Email Sent!',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spacingM),
        Text(
          'We\'ve sent a password reset link to',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spacingS),
        Text(
          _emailController.text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.primaryBlue,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spacingXXL),

        // Back to login button
        CustomButton(
          text: 'Back to Login',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_role.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _rememberMe;
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _rememberMe = false;
    _obscurePassword = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      final user = authProvider.currentUser;

      if (user == null) return;

      // Check if email is verified
      if (!user.isEmailVerified) {
        Navigator.pushReplacementNamed(
          context,
          AppConstants.otpVerificationRoute,
          arguments: user.email,
        );
        return;
      }

      // Navigate based on role
      String route;
      switch (user.role) {
        case UserRole.customer:
          route = AppConstants.customerHomeRoute;
          break;
        case UserRole.pilot:
          route = AppConstants.pilotHomeRoute;
          break;
        case UserRole.staff:
          route = AppConstants.staffHomeRoute;
          break;
        case UserRole.attendant:
          route = AppConstants.attendantHomeRoute;
          break;
        case UserRole.admin:
          route = AppConstants.adminHomeRoute;
          break;
      }

      Navigator.pushReplacementNamed(context, route);
    } else {
      _showError(authProvider.errorMessage ?? 'Login failed');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.maryOrangeRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
      ),
    );
  }

  InputDecoration _getInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: AppTheme.maryBlack),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: 22, // Increased padding to prevent cropping
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        borderSide: const BorderSide(color: AppTheme.maryOrangeRed, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        borderSide: const BorderSide(color: AppTheme.maryOrangeRed, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              children: [
                // Form Overlay
                SizedBox(
                  width: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.width * 0.75
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.maryGreen.withValues(
                        alpha: 0.05,
                      ), // Translucent neon green
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      border: Border.all(
                        color: AppTheme.maryGreen.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: AppTheme.spacingM),

                          // Header (Moved Inside)
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.purple,
                                AppTheme.maryOrangeRed,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              'MaryAir',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    fontSize: 42,
                                    color:
                                        Colors.white, // Required for ShaderMask
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingS),
                          Text(
                            'Where quality meets affordability',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppTheme.maryOrangeRed,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppTheme.spacingXL),

                          const SizedBox(height: AppTheme.spacingM),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            decoration: _getInputDecoration(
                              'Email Address',
                              Icons.email_outlined,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateEmail,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Password
                          TextFormField(
                            controller: _passwordController,
                            decoration:
                                _getInputDecoration(
                                  'Password',
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppTheme.maryBlack,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingS),

                          // Remember Me & Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    activeColor: AppTheme.maryOrangeRed,
                                    checkColor: Colors.black,
                                    side: const BorderSide(
                                      color: AppTheme.maryGreen,
                                    ),
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppConstants.forgotPasswordRoute,
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: AppTheme.maryOrangeRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacingXL),

                          // Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: Consumer<AuthProvider>(
                              builder: (context, authProvider, _) {
                                return ElevatedButton(
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.maryGreen,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusM,
                                      ),
                                    ),
                                    elevation: 5,
                                    shadowColor: AppTheme.maryGreen.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  child: authProvider.isLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingL),

                          // Sign Up Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppConstants.registerRoute,
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: AppTheme.maryOrangeRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

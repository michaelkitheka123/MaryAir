import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../providers/auth_provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();
  int _resendCountdown = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _canResend = false;
    _resendCountdown = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0 && mounted) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        if (mounted) {
          setState(() {
            _canResend = true;
          });
        }
        timer.cancel();
      }
    });
  }

  Future<void> _handleVerification() async {
    if (_otpController.text.length != 6) {
      _showError('Please enter a valid 6-digit OTP');
      return;
    }

    final authProvider = context.read<AuthProvider>();

    // Determine context (Registration vs Login/Verification)
    final args = ModalRoute.of(context)?.settings.arguments;
    final isRegistration = args is Map && args['isRegistration'] == true;

    bool success;
    if (isRegistration) {
      success = await authProvider.completeRegistration(
        otp: _otpController.text,
      );
    } else {
      success = await authProvider.verifyOTP(widget.email, _otpController.text);
    }

    if (!mounted) return;

    if (success) {
      _showSuccess(
        isRegistration
            ? 'Account created successfully!'
            : 'Email verified successfully!',
      );

      // Delay slightly to show success message before navigation
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      // Redirect to Login
      Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
    } else {
      _showError(authProvider.errorMessage ?? 'Invalid or expired OTP');
      // Clear OTP on failure
      _otpController.clear();
      _focusNode.requestFocus();
    }
  }

  Future<void> _handleResendOTP() async {
    if (!_canResend) return;

    final authProvider = context.read<AuthProvider>();

    // Reset timer immediately for feedback
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    final success = await authProvider.resendOTP(widget.email);

    if (!mounted) return;

    if (success) {
      _showSuccess('OTP sent successfully!');
      _startCountdown();
    } else {
      _showError('Failed to resend OTP');
      // Reset state if failed
      setState(() {
        _canResend = true;
        _resendCountdown = 0;
      });
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

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.black)),
        backgroundColor: AppTheme.maryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Default: Orange Box
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), // Dark translucent fill
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.maryOrangeRed.withOpacity(0.5),
          width: 1.5,
        ),
      ),
    );

    // Focused: Green Box with Glow
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppTheme.maryGreen, width: 2),
        color: AppTheme.maryGreen.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.maryGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );

    // Submitted: Solid Green Border
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppTheme.maryGreen, width: 2),
      ),
    );

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
                      color: AppTheme.maryGreen.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      border: Border.all(
                        color: AppTheme.maryGreen.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    child: Column(
                      children: [
                        const SizedBox(height: AppTheme.spacingM),

                        // Header
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
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

                        // Instructions
                        Text(
                          'Enter the verification code sent to',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.email,
                          style: const TextStyle(
                            color: AppTheme.maryGreen,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingXL),

                        // Pinput Field
                        Pinput(
                          controller: _otpController,
                          focusNode: _focusNode,
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          onCompleted: (_) => _handleVerification(),
                          showCursor: true,
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: AppTheme.maryGreen,
                              ),
                            ],
                          ),
                          enableSuggestions: true,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: AppTheme.spacingXL),

                        // Timer & Resend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!_canResend) ...[
                              const Icon(
                                Icons.timer_outlined,
                                color: AppTheme.maryOrangeRed,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Resend in $_resendCountdown s',
                                style: const TextStyle(
                                  color: AppTheme.maryOrangeRed,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "Didn't receive code? ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: _handleResendOTP,
                                child: const Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    color: AppTheme.maryGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppTheme.maryGreen,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacingXL),

                        // Verify Button
                        SizedBox(
                          width: double.infinity,
                          child: Consumer<AuthProvider>(
                            builder: (context, authProvider, _) {
                              return ElevatedButton(
                                onPressed: authProvider.isLoading
                                    ? null
                                    : _handleVerification,
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
                                        'Verify Email',
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
                        const SizedBox(height: AppTheme.spacingM),

                        // Back to Login
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            AppConstants.loginRoute,
                          ),
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
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

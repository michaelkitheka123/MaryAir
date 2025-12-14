import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../../utils/countries.dart';

import '../../widgets/password_strength_indicator.dart';
import '../../providers/auth_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  final _nationalityController = TextEditingController();

  bool _acceptedTerms = false;
  String _password = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _selectedNationalityIndex = 0;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _acceptedTerms = false;
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    _selectedNationalityIndex = 0;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_dobController.text.isEmpty) {
      _showError('Please select your date of birth');
      return;
    }

    if (!_acceptedTerms) {
      _showError('Please accept the terms and conditions');
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.initiateRegistration(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim().isNotEmpty
          ? _phoneController.text.trim()
          : null,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(
        context,
        AppConstants.otpVerificationRoute,
        arguments: {
          'email': _emailController.text.trim(),
          'isRegistration': true,
        },
      );
    } else {
      _showError(authProvider.errorMessage ?? 'Registration initiation failed');
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
        vertical: 22,
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
                      color: AppTheme.maryGreen.withValues(alpha: 0.05),
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

                          // Full Name
                          TextFormField(
                            controller: _fullNameController,
                            decoration: _getInputDecoration(
                              'Full Name',
                              Icons.person_outline,
                            ),
                            keyboardType: TextInputType.name,
                            validator: Validators.validateName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Date of Birth (Inline Wheel)
                          InputDecorator(
                            isEmpty: false,
                            decoration:
                                _getInputDecoration(
                                  'Date of Birth',
                                  Icons.calendar_today,
                                ).copyWith(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingM,
                                    vertical: 10,
                                  ),
                                ),
                            child: SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  // Month Picker
                                  Expanded(
                                    child: CupertinoPicker.builder(
                                      scrollController:
                                          FixedExtentScrollController(
                                            initialItem:
                                                (_selectedDate?.month ?? 1) - 1,
                                          ),
                                      itemExtent: 40,
                                      onSelectedItemChanged: (index) {
                                        final newDate = DateTime(
                                          _selectedDate?.year ??
                                              DateTime.now().year,
                                          index + 1,
                                          _selectedDate?.day ?? 1,
                                        );
                                        setState(() {
                                          _selectedDate = newDate;
                                          _dobController.text =
                                              "${newDate.day}/${newDate.month}/${newDate.year}";
                                        });
                                      },
                                      childCount: 12,
                                      itemBuilder: (context, index) {
                                        final monthName = [
                                          'Jan',
                                          'Feb',
                                          'Mar',
                                          'Apr',
                                          'May',
                                          'Jun',
                                          'Jul',
                                          'Aug',
                                          'Sep',
                                          'Oct',
                                          'Nov',
                                          'Dec',
                                        ][index];
                                        return Center(
                                          child: Text(
                                            monthName,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                      selectionOverlay: Container(),
                                    ),
                                  ),
                                  // Day Picker
                                  Expanded(
                                    child: CupertinoPicker.builder(
                                      scrollController:
                                          FixedExtentScrollController(
                                            initialItem:
                                                (_selectedDate?.day ?? 1) - 1,
                                          ),
                                      itemExtent: 40,
                                      onSelectedItemChanged: (index) {
                                        final newDate = DateTime(
                                          _selectedDate?.year ??
                                              DateTime.now().year,
                                          _selectedDate?.month ?? 1,
                                          index + 1,
                                        );
                                        setState(() {
                                          _selectedDate = newDate;
                                          _dobController.text =
                                              "${newDate.day}/${newDate.month}/${newDate.year}";
                                        });
                                      },
                                      childCount: 31,
                                      itemBuilder: (context, index) => Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      selectionOverlay: Container(),
                                    ),
                                  ),
                                  // Year Picker
                                  Expanded(
                                    child: CupertinoPicker.builder(
                                      scrollController:
                                          FixedExtentScrollController(
                                            initialItem:
                                                (_selectedDate?.year ??
                                                    DateTime.now().year) -
                                                1900,
                                          ),
                                      itemExtent: 40,
                                      onSelectedItemChanged: (index) {
                                        final newYear = 1900 + index;
                                        final newDate = DateTime(
                                          newYear,
                                          _selectedDate?.month ?? 1,
                                          _selectedDate?.day ?? 1,
                                        );
                                        setState(() {
                                          _selectedDate = newDate;
                                          _dobController.text =
                                              "${newDate.day}/${newDate.month}/${newDate.year}";
                                        });
                                      },
                                      childCount:
                                          DateTime.now().year - 1900 + 1,
                                      itemBuilder: (context, index) => Center(
                                        child: Text(
                                          '${1900 + index}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      selectionOverlay: Container(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Nationality (Inline Wheel)
                          InputDecorator(
                            isEmpty: false,
                            decoration:
                                _getInputDecoration(
                                  'Nationality',
                                  Icons.flag_outlined,
                                ).copyWith(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingM,
                                    vertical: 10,
                                  ),
                                ),
                            child: SizedBox(
                              height: 60,
                              child: CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                  initialItem: _selectedNationalityIndex,
                                ),
                                itemExtent: 40,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedNationalityIndex = index;
                                    _nationalityController.text =
                                        CountryData.countries[index];
                                  });
                                },
                                children: CountryData.countries
                                    .map(
                                      (country) => Center(
                                        child: Text(
                                          country,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingM),

                          // Email (unchanged)
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

                          // Phone Number (unchanged)
                          TextFormField(
                            controller: _phoneController,
                            decoration: _getInputDecoration(
                              'Phone Number',
                              Icons.phone_outlined,
                            ),
                            keyboardType: TextInputType.phone,
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
                            validator: Validators.validatePassword,
                            onChanged: (value) =>
                                setState(() => _password = value),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingS),

                          // Password Strength
                          PasswordStrengthIndicator(password: _password),
                          const SizedBox(height: AppTheme.spacingM),

                          // Confirm Password
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration:
                                _getInputDecoration(
                                  'Confirm Password',
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppTheme.maryBlack,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                            obscureText: _obscureConfirmPassword,
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                  value,
                                  _passwordController.text,
                                ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingL),

                          // Terms
                          Row(
                            children: [
                              Checkbox(
                                value: _acceptedTerms,
                                onChanged: (value) => setState(
                                  () => _acceptedTerms = value ?? false,
                                ),
                                activeColor: AppTheme.maryOrangeRed,
                                checkColor: Colors.black,
                                side: BorderSide(color: AppTheme.maryBlack),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(
                                    () => _acceptedTerms = !_acceptedTerms,
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'I agree to the ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black87),
                                      children: [
                                        TextSpan(
                                          text: 'Terms & Conditions',
                                          style: TextStyle(
                                            color: AppTheme.maryOrangeRed,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacingXL),

                          // Register Button
                          SizedBox(
                            width: double.infinity,
                            child: Consumer<AuthProvider>(
                              builder: (context, authProvider, _) {
                                return ElevatedButton(
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : _handleRegistration,
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
                                          'Create Account',
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

                          // Sign In Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? ',
                                style: TextStyle(color: Colors.black87),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppConstants.loginRoute,
                                  );
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AppTheme.maryOrangeRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacingM),
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

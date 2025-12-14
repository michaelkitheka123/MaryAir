class AppConstants {
  // App Info
  static const String appName = 'MaryAir';
  static const String appTagline = 'Your Journey, Our Priority';

  // Routes

  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String otpVerificationRoute = '/otp-verification';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String customerHomeRoute = '/customer-home';
  static const String pilotHomeRoute = '/pilot-home';
  static const String staffHomeRoute = '/staff-home';
  static const String attendantHomeRoute = '/attendant-home';
  static const String adminHomeRoute = '/admin-home';

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String otpCollection = 'otp_codes';

  // Shared Preferences Keys
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userIdKey = 'userId';
  static const String userEmailKey = 'userEmail';
  static const String rememberMeKey = 'rememberMe';

  // OTP Settings
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 10;
  static const int otpResendSeconds = 60;

  // Validation
  static const int minPasswordLength = 8;
  static const int minNameLength = 2;
  static const int minPhoneLength = 10;

  // Error Messages
  static const String networkError =
      'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
  static const String invalidCredentials = 'Invalid email or password.';
  static const String emailAlreadyExists = 'This email is already registered.';
  static const String weakPassword = 'Password is too weak.';
  static const String userNotFound = 'User not found.';
  static const String invalidOTP = 'Invalid or expired OTP.';

  // Success Messages
  static const String registrationSuccess = 'Registration successful!';
  static const String loginSuccess = 'Login successful!';
  static const String otpSentSuccess = 'OTP sent to your email.';
  static const String otpVerifiedSuccess = 'Email verified successfully!';
  static const String passwordResetSuccess = 'Password reset email sent.';
}

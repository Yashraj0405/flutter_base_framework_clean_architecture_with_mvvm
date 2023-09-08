// Abstract base class for different login events
abstract class LoginEvent {}

// Represents the event when the user presses the login button
class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

// Represents the event when the user presses the "Get OTP" button
class GetOTPButtonPressed extends LoginEvent {
  final String contactNumber;
  GetOTPButtonPressed({required this.contactNumber});
}

// Represents the event when the user presses the "Validate OTP" button
class ValidateButtonPressed extends LoginEvent {
  final String validateOtp;
  ValidateButtonPressed({
    required this.validateOtp,
  });
}

class SubmitButtomPressed extends LoginEvent {
  final String email;
  final String newPassword;
  final String confirmPassword;

  SubmitButtomPressed({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });
}

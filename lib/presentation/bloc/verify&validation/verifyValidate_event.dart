abstract class VerifyValidateEvent {}

class VerifyEmailButtonPressed extends VerifyValidateEvent {
  final String verifyEmail;
  VerifyEmailButtonPressed({required this.verifyEmail});
}

class VerifyContactButtonPressed extends VerifyValidateEvent {
  final String contactNumber;
  VerifyContactButtonPressed({required this.contactNumber});
}

class ValidateOtpButtonPressed extends VerifyValidateEvent {
  final String validateOtp;
  ValidateOtpButtonPressed({required this.validateOtp});
}

class GenerateOtpButtonPressed extends VerifyValidateEvent {
  final String email;
  GenerateOtpButtonPressed({required this.email});
}

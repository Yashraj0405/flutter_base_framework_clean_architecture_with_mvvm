abstract class SignUpEvent {}

class CreateAccountButtonPressed extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String contactNo;
  final String otp;

  CreateAccountButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNo,
    required this.otp,
  });
}

class SignUpCreateAccountButtonPressed extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String contactNo;
  final String password;
  final String otp;

  SignUpCreateAccountButtonPressed(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.contactNo,
      required this.password,
      required this.otp});
}

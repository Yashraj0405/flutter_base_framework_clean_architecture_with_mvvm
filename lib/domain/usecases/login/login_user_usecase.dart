import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/forgotPassword.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/otp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/user.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/validate.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/login/authentication_repository.dart';

class LoginUserUsecase {
  // Repository that provides authentication-related methods.
  final AuthenticationRepository repository;

  // Constructor to inject the repository dependency.
  LoginUserUsecase(this.repository);

  // Initiates login using email and password.
  Future<User> login(String email, String password) async {
    // Delegates the login operation to the repository.
    // Returns the result of the login process as a User object.
    return await repository.loginUser(email, password);
  }

  // Initiates login using an OTP sent to a contact number.
  Future<Otp> loginOtp(String contactNumber) async {
    // Delegates the OTP-based login operation to the repository.
    // Returns the result of the OTP-based login process as an Otp object.
    return await repository.loginOtp(contactNumber);
  }

  // Validates an OTP provided by the user.
  Future<Validate> validateOtp(
    String otp,
  ) async {
    // Delegates the OTP validation operation to the repository.
    // Returns the result of the OTP validation process as a Validate object.
    return await repository.validateOtp(otp);
  }

  //Forgot Password
  Future<ForgotPassword> forgotPassword(
    String email,
    String newPassword,
    String confirmNewPassword,
  ) async {
    return await repository.forgotPassword(
      email,
      newPassword,
      confirmNewPassword,
    );
  }


}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/forgotPassword.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/otp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/user.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/validate.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/varifyEmail.dart';

// Abstract class outlining authentication-related methods.
abstract class AuthenticationRepository {
  // Initiates login using username and password.
  Future<User> loginUser(String username, String password);

  // Initiates login using OTP sent to a contact number.
  Future<Otp> loginOtp(String contactNumber);

  // Validates an OTP provided by the user.
  Future<Validate> validateOtp(String otp,);

  //Forgot Password
  Future<ForgotPassword> forgotPassword(
      String email, String newPassword, String confirmNewPassword);

 
}

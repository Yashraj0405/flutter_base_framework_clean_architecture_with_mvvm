import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/forgotPassword.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/otp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/validate.dart';

import '../../../domain/entities/login/user.dart';

// Abstract base class for different login states
abstract class LoginState {}

// Represents the initial state of the login process
class LoginInitial extends LoginState {}

// Represents the state when the login process is in progress
class LoginLoading extends LoginState {}

// Represents the state when the login process is successful
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess({required this.user});
}

// Represents the state when generating OTP  is successful
class OtpSuccess extends LoginState {
  final Otp otp;
  OtpSuccess({required this.otp});
}

// Represents the state when OTP validation is successful
class ValidateOtpSuccess extends LoginState {
  final Validate validate;
  ValidateOtpSuccess({required this.validate});
}

class ForgotPasswordSuccess extends LoginState {
  final ForgotPassword forgotPassword;
  ForgotPasswordSuccess({required this.forgotPassword});
}

// Represents the state when the login process fails
class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

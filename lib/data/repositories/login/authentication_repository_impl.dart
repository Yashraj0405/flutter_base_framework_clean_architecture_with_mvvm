import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/login/forgot_password_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/login/otp_authentication_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/login/validate_otp_authentication_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/login/forgotPasswordModel.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/login/otpModel.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/login/userModel.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/login/authentication_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/login/validateModel.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/forgotPassword.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/otp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/user.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/validate.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/login/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi authenticationApi;
  final OtpAuthenticationApi otpAuthenticationApi;
  final ValidateOtpAutenticationAPi validateOtpAutenticationAPi;
  final ForgotPasswordApi forgotPasswordApi;

  // Constructor to initialize the repository with required data sources
  AuthenticationRepositoryImpl(
    this.authenticationApi,
    this.otpAuthenticationApi,
    this.validateOtpAutenticationAPi,
    this.forgotPasswordApi,
  );

  // Implement the loginUser method using email and password
  @override
  Future<User> loginUser(String username, String password) async {
    final Map<String, dynamic> response =
        await authenticationApi.loginUser(username, password);

    // Create a UserModel from the response data
    final user = UserModel(
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
      status: response['status'],
      message: response['message'],
      tracingId: response['tracingId'],
      deviceUuid: response['device_uuid'],
    );
    return user;
  }

  // Implement the loginOtp method using the contact number
  @override
  Future<Otp> loginOtp(String contactNumber) async {
    final Map<String, dynamic> response =
        await otpAuthenticationApi.loginUserOtp(contactNumber);

    // Create an OtpModel from the response dataF
    final otp = OtpModel(
      status: response['status'],
      message: response['message'],
      otp: response[response],
    );
    return otp;
  }

  // Implement the validateOtp method using the otp
  @override
  Future<Validate> validateOtp(
    String otp,
  ) async {
    final Map<String, dynamic> response =
        await validateOtpAutenticationAPi.ValidateOtp(otp);

    // Create a ValidateModel from the response data
    final validateOtp = ValidateModel(
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
      status: response['status'],
      message: response['message'],
    );
    return validateOtp;
  }

  @override
  Future<ForgotPassword> forgotPassword(
    String email,
    String newPassword,
    String confirmNewPassword,
  ) async {
    final Map<String, dynamic> response =
        await forgotPasswordApi.forgotPassword(
      email,
      newPassword,
      confirmNewPassword,
    );

    final forgotPassword = ForgotPasswordModel(
      status: response['status'],
      message: response['message'],
    );
    return forgotPassword;
  }


}

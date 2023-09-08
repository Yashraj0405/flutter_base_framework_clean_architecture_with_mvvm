import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/validateOtpApi.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/verifyContact_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/verify&validate/validateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/generateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/validateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/varifyEmail.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/verify&validate/verify&validate_repository.dart';

import '../../data_sources/remote_data_sources/verify&validate/verifyUsernameExistsApi.dart';
import '../../model/login/verifyEmailModel.dart';
import '../../model/verify&validate/VerifyContactModel.dart';
import '../../model/verify&validate/generateOtp.dart';

class VerifyValidateRepositoryImpl implements VerifyValidateRepository {
  final GenerateOtpApi generateOtpApi;
  final ValidateOtpApi validateOtpApi;
  final VerifyUsernameExistsApi verifyUsernameExistsApi;
  final VerifyContactApi verifyContactApi;

  VerifyValidateRepositoryImpl(
    this.generateOtpApi,
    this.validateOtpApi,
    this.verifyUsernameExistsApi,
    this.verifyContactApi,
  );

  @override
  Future<GenerateOtp> generateOtp(String email) async {
    final Map<String, dynamic> response =
        await generateOtpApi.generateOtp(email);
    final generateOtp = GenerateOtpModel(
      status: response['status'],
      message: response['message'],
      otp: response['otp'],
    );
    return generateOtp;
  }

  @override
  Future<ValidateOtp> validateOtp(String otp) async {
    final Map<String, dynamic> response = await validateOtpApi.validateOtp(otp);
    final validateOtp = ValidateOtpModel(
      status: response['status'],
      message: response['message'],
      otp: response['otp'],
    );
    return validateOtp;
  }

  @override
  Future<VerifyEmail> verifyEmail(String email) async {
    final Map<String, dynamic> response =
        await verifyUsernameExistsApi.VerifyEmail(email);
    final verifyEmail = VerifyEmailModel(
      status: response['status'],
      isUserExists: response['isUserExists'],
    );
    return verifyEmail;
  }

  @override
  Future<VerifyContact> verifyContact(String number) async {
    final Map<String, dynamic> response =
        await verifyContactApi.verifyContact(number);
    final verifyContact = VerifyContactModel(
      status: response['status'],
      message: response['message'],
      otp: response['otp'],
    );
    return verifyContact;
  }
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/validateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/verify&validate/verify&validate_repository.dart';

import '../../../data/data_sources/remote_data_sources/verify&validate/validateOtpApi.dart';
import '../../entities/verify&validate/generateOtp.dart';
import '../../entities/verify&validate/varifyEmail.dart';

class VerifyValidateUseCase {
  final VerifyValidateRepository verifyValidateRepository;

  VerifyValidateUseCase(this.verifyValidateRepository);

  Future<VerifyEmail> verifyEmail(String email) async {
    return await verifyValidateRepository.verifyEmail(email);
  }

  Future<VerifyContact> verifyContact(String number) async {
    return await verifyValidateRepository.verifyContact(number);
  }

  Future<GenerateOtp> generateOtp(String email) async {
    return await verifyValidateRepository.generateOtp(email);
  }

  Future<ValidateOtp> validateOtp(String otp) async {
    return await verifyValidateRepository.validateOtp(otp);
  }
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/validateOtp.dart';
import '../../entities/verify&validate/generateOtp.dart';
import '../../entities/verify&validate/varifyEmail.dart';
import '../../entities/verify&validate/verifyContact.dart';

abstract class VerifyValidateRepository {
  Future<VerifyEmail> verifyEmail(String email);
  Future<VerifyContact> verifyContact(String number);
  Future<GenerateOtp> generateOtp(String email);
  Future<ValidateOtp> validateOtp(String otp);
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';

import '../../../domain/entities/verify&validate/generateOtp.dart';
import '../../../domain/entities/verify&validate/validateOtp.dart';
import '../../../domain/entities/verify&validate/varifyEmail.dart';

abstract class VerifyValidateState {}

class VerifyValidateInitial extends VerifyValidateState {}

class VerifyValidateLoading extends VerifyValidateState {}

class VerifyEmailSuccess extends VerifyValidateState {
  final VerifyEmail verifyEmail;
  VerifyEmailSuccess({required this.verifyEmail});
}

class VerifyContactSuccess extends VerifyValidateState {
  final VerifyContact verifyContact;
  VerifyContactSuccess({required this.verifyContact});
}

class ValidateOtpSuccessState extends VerifyValidateState {
  final ValidateOtp validateOtp;
  ValidateOtpSuccessState({required this.validateOtp});
}

class GenerateOtpSuccess extends VerifyValidateState {
  final GenerateOtp generateOtp;
  GenerateOtpSuccess({required this.generateOtp});
}

class VerifyValidateFailure extends VerifyValidateState {
  final String error;
  VerifyValidateFailure({required this.error});
}

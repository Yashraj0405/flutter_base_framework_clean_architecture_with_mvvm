import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/createUser.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/generateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/signUp.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final CreateUser createUser;
  SignUpSuccess({required this.createUser});
}

class SignUpEmailSuccess extends SignUpState {
  final SignUp signUp;
  SignUpEmailSuccess({required this.signUp});
}

class SignUpFailure extends SignUpState {
  final String error;
  SignUpFailure({required this.error});
}

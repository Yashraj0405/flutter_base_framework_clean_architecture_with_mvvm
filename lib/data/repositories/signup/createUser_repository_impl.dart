import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/signup/createUser_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/signup/signup_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/signup/createUserModel.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/signup/signUpModel.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/createUser.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/signUp.dart';

import '../../../domain/repositories/signup/createUser_repository.dart';

class CreateUserRepositoryImpl implements CreateUserRepository {
  final SignUpApi signUpApi;
  final CreateUserApi createUserApi;

  CreateUserRepositoryImpl(
    this.createUserApi,
    this.signUpApi,
  );

  @override
  Future<CreateUser> createuser(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String otp,
  ) async {
    final Map<String, dynamic> response = await createUserApi.createUser(
      firstName,
      lastName,
      email,
      contactNo,
      otp,
    );
    final createUser = CreateUserModel(
      status: response['status'],
      message: response['message'],
    );
    return createUser;
  }

  @override
  Future<SignUp> createUserUsingEmail(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String password,
    String otp,
  ) async {
    final Map<String, dynamic> response = await signUpApi.createUserUsingEmail(
      firstName,
      lastName,
      email,
      contactNo,
      password,
      otp,
    );
    final signupUsingEmail = SignUpModel(
      status: response['status'],
      message: response['message'],
    );
    return signupUsingEmail;
  }
}

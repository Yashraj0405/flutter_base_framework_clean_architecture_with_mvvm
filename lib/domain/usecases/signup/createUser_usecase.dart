import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/createUser.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/generateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/signUp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/validateOtp.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/signup/createUser_repository.dart';

class CreateUserUsecase {
  final CreateUserRepository createUserRepository;

  CreateUserUsecase(this.createUserRepository);

  Future<CreateUser> createUser(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String otp,
  ) async {
    return await createUserRepository.createuser(
      firstName,
      lastName,
      email,
      contactNo,
      otp,
    );
  }

  Future<SignUp> createUserUsingEmai(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String password,
    String otp,
  ) {
    return createUserRepository.createUserUsingEmail(
      firstName,
      lastName,
      email,
      contactNo,
      password,
      otp,
    );
  }
}

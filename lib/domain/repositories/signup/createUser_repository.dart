import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/createUser.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/signUp.dart';

abstract class CreateUserRepository {
  Future<CreateUser> createuser(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String otp,
  );

  Future<SignUp> createUserUsingEmail(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String password,
    String otp,
  );
}

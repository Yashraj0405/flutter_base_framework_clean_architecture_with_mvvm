import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/createUser.dart';

class CreateUserModel extends CreateUser {
  final bool status;
  final String message;

  CreateUserModel({required this.status, required this.message})
      : super(
          status: status,
          message: message,
        );

  factory CreateUserModel.fromJson(Map<String, dynamic> json) {
    return CreateUserModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

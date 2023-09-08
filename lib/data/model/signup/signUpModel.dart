import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/signup/signUp.dart';

class SignUpModel extends SignUp {
  final bool status;
  final String message;

  SignUpModel({
    required this.status,
    required this.message,
  }) : super(
          status: status,
          message: message,
        );

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

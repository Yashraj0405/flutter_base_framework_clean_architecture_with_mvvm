import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/forgotPassword.dart';

class ForgotPasswordModel extends ForgotPassword {
  final bool status;
  final String message;

  ForgotPasswordModel({
    required this.status,
    required this.message,
  }) : super(
          status: status,
          message: message,
        );

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/varifyEmail.dart';

class VerifyEmailModel extends VerifyEmail {
  final bool status;
  final bool isUserExists;

  VerifyEmailModel({
    required this.status,
    required this.isUserExists,
  }) : super(
          status: status,
          isUserExists: isUserExists,
        );

  factory VerifyEmailModel.fromJson(Map<String, dynamic> json) =>
      VerifyEmailModel(
        status: json["status"],
        isUserExists: json["isUserExists"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "isUserExists": isUserExists,
      };
}

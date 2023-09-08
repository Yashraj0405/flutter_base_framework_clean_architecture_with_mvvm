import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/verifyContact.dart';

class VerifyContactModel extends VerifyContact {
  final bool status;
  final String message;
  final dynamic otp;

  VerifyContactModel({
    required this.status,
    required this.message,
    required this.otp,
  }) : super(
          status: status,
          message: message,
          otp: otp,
        );

  factory VerifyContactModel.fromJson(Map<String, dynamic> json) {
    return VerifyContactModel(
      status: json['status'],
      message: json['message'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otp": otp,
      };
}

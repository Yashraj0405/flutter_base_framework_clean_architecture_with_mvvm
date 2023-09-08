import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/generateOtp.dart';

class GenerateOtpModel extends GenerateOtp {
  final bool status;
  final String message;
  final dynamic otp;

  GenerateOtpModel({
    required this.status,
    required this.message,
    required this.otp,
  }) : super(
          status: status,
          message: message,
          otp: otp,
        );

  factory GenerateOtpModel.fromJson(Map<String, dynamic> json) {
    return GenerateOtpModel(
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

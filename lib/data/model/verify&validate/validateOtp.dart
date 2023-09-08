import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/verify&validate/validateOtp.dart';

class ValidateOtpModel extends ValidateOtp {
  final bool status;
  final String message;
  final dynamic otp;

  ValidateOtpModel({
    required this.status,
    required this.message,
    required this.otp,
  }) : super(
          status: status,
          message: message,
          otp: otp,
        );
  factory ValidateOtpModel.fromJson(Map<String, dynamic> json) =>
      ValidateOtpModel(
        status: json["status"],
        message: json["message"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otp": otp,
      };
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/otp.dart';

// DefineD the OtpModel class that extends Otp (entity)
class OtpModel extends Otp {
  final bool status;
  final String message;
  final dynamic otp;

  // Constructor to initialize the model
  OtpModel({
    required this.status,
    required this.message,
    required this.otp,
  }) : super(
          status: status,
          message: message,
          otp: otp,
        );

  // Factory constructor to create an OtpModel instance from JSON
  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        status: json["status"],
        message: json["message"],
        otp: json["otp"],
      );
  // Factory constructor to create an OtpModel instance from JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otp": otp,
      };
}

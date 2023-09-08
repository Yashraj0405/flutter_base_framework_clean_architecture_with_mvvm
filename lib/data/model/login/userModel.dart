import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/user.dart';

// Defined the UserModel class that extends User (entity)
class UserModel extends User {
  final String accessToken;
  final String refreshToken;
  final bool status;
  final String message;
  final String tracingId;
  final String deviceUuid;

  // Constructor to initialize the model
  UserModel({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
    required this.message,
    required this.tracingId,
    required this.deviceUuid,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          status: status,
          message: message,
          tracingId: tracingId,
          deviceUuid: deviceUuid,
        );

  // Factory constructor to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      status: json['status'],
      message: json['message'],
      tracingId: json['tracingId'],
      deviceUuid: json['device_uuid'],
    );
  }

  // Method to convert the UserModel to JSON
  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "status": status,
        "message": message,
        "tracingId": tracingId,
        "device_uuid": deviceUuid,
      };
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/login/validate.dart';

// Defined the ValidateModel class that extends Validate (entity)
class ValidateModel extends Validate {
  final String accessToken;
  final String refreshToken;
  final bool status;
  final String message;

  // Constructor to initialize the model
  ValidateModel({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
    required this.message,
  }) : super(
            accessToken: accessToken,
            refreshToken: refreshToken,
            status: status,
            message: message);

  // Factory constructor to create a ValidateModel instance from JSON
  factory ValidateModel.fromJson(Map<String, dynamic> json) => ValidateModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        status: json["status"],
        message: json["message"],
      );

  // Method to convert the ValidateModel to JSON
  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "status": status,
        "message": message,
      };
}

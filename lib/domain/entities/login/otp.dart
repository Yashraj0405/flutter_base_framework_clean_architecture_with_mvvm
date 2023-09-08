class Otp {
  // Indicates whether the OTP operation was successful or not.
  final bool status;
  // A message related to the OTP operation.
  final String message;
  // The actual OTP value. The type is dynamic, allowing for various data types.
  final dynamic otp;

  Otp({
    required this.status, // Constructor parameter to assign a value to the 'status' property.
    required this.message, // Constructor parameter to assign a value to the 'status' property.
    required this.otp, // Constructor parameter to assign a value to the 'otp' property.
  });
}

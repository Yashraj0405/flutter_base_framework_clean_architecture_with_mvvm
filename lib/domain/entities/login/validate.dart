class Validate {
  final String accessToken; // Access token associated with validation.
  final String refreshToken; // Refresh token associated with validation.
  final bool status; // Indicates whether the validation was successful or not.
  final String message; // A message related to the validation.

  Validate({
    required this.accessToken, // Constructor parameter to assign a value to the 'accessToken' property.
    required this.refreshToken, // Constructor parameter to assign a value to the 'refreshToken' property.
    required this.status, // Constructor parameter to assign a value to the 'status' property.
    required this.message, // Constructor parameter to assign a value to the 'message' property.
  });
}



class User {
  final String accessToken; // Access token associated with the user.
  final String refreshToken; // Refresh token associated with the user.
  final bool
      status; // Indicates whether the user operation was successful or not.
  final String message; // A message related to the user operation.
  final String tracingId; // Tracing ID associated with the user.
  final String
      deviceUuid; // UUID (Universally Unique Identifier) associated with the user's device.

  User({
    required this.accessToken, // Constructor parameter to assign a value to the 'accessToken' property.
    required this.refreshToken, // Constructor parameter to assign a value to the 'refreshToken' property.
    required this.status, // Constructor parameter to assign a value to the 'status' property.
    required this.message, // Constructor parameter to assign a value to the 'message' property.
    required this.tracingId, // Constructor parameter to assign a value to the 'tracingId' property.
    required this.deviceUuid, // Constructor parameter to assign a value to the 'deviceUuid' property.
  });
}

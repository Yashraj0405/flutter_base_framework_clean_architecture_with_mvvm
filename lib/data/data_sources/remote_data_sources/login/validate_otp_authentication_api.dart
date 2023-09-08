import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

class ValidateOtpAutenticationAPi {
  final ApiClient apiClient;

  // Constructor to inject the ApiClient instance
  ValidateOtpAutenticationAPi(this.apiClient);

  // Method to perform the Validation for the OTP recieved
  Future<Map<String, dynamic>> ValidateOtp(String otp) async {
    // Define the API endpoint path
    const path = "https://auth.truptitech.com/api/v1/login";
    var mobile = PreferenceManager.getContactNumber();
    // Create the request body
    final Map<String, dynamic> body = {
      "tenant_id": '1',
      "app_name": 'CONSUMER',
      "username": mobile,
      "otp": otp,
    };

    // Create the request body
    final response = await apiClient.post(path, body);
    // Create the validation was successful
    final bool success = response['status'];
    if (success) {
      PreferenceManager.setLoggedIn(success);
      final accessToken = response["accessToken"];
      PreferenceManager.setAccessToken(
          accessToken); // Store the access token in the preference manager
    }
    print(PreferenceManager.isLoggedIn().toString());
    return success ? response : {}; // Return the response
  }

 
}

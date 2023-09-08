import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

import '../../../../app/preference_manager.dart';
import '../../../../presentation/manager/constant/toast_constant.dart';

class OtpAuthenticationApi {
  final ApiClient apiClient;

  // Constructor to inject the ApiClient instance
  OtpAuthenticationApi(this.apiClient);

  // Method to perform Login using OTP
  Future<Map<String, dynamic>> loginUserOtp(String contactNumber) async {
    // Define the API endpoint path
    const path = 'https://auth.truptitech.com/api/v1/otp';

    // Create the request body
    final Map<String, dynamic> body = {
      'app_name': 'CONSUMER',
      'username': contactNumber,
      'tenantId': '1',
      'usage': 'login',
    };

    // Send a POST request using the apiClient
    final response = await apiClient.post(path, body);
    // Check if the generating OTP was successful
    final bool otpSuccess = response['status'];
    if (otpSuccess) {
      
      final dynamic otp = response['otp'];
      PreferenceManager.setOtpNumber(
          otp.toString()); // Store the otp number in the preference manager
      ToastMessage.showMessage(
          PreferenceManager.getOtpNumber()!); //Toast the OTP number
    }

   
    return otpSuccess ? response : {}; // Return the response
  }
}

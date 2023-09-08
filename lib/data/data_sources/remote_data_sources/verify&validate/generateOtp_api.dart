import 'dart:math';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

import '../../../../app/preference_manager.dart';
import '../../../../presentation/manager/constant/toast_constant.dart';

class GenerateOtpApi {
  final ApiClient apiClient;

  GenerateOtpApi(this.apiClient);

  Future<Map<String, dynamic>> generateOtp(String email) async {
    const path = "https://jaspurauthuat.skandhanetworks.com/api/v1/otp";
    final Map<String, dynamic> body = {
      "app_name": "JASPURBO",
      "username": email,
      "email": email,
      "usage": "registration"
    };

    final response = await apiClient.post(path, body);
    print('===========================');
    print(response);
    final bool status = response['status'];

    if (status) {
      final dynamic otp = response['otp'];
      PreferenceManager.setOtpNumber(
          otp.toString()); // Store the otp number in the preference manager
      ToastMessage.showMessage(
          PreferenceManager.getOtpNumber()!); //Toast the OTP number
    }
    return status ? response : {};
  }
}

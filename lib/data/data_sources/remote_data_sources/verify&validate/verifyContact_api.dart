import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

import '../../../../app/preference_manager.dart';
import '../../../../presentation/manager/constant/toast_constant.dart';

class VerifyContactApi {
  final ApiClient apiClient;

  VerifyContactApi(this.apiClient);

  Future<Map<String, dynamic>> verifyContact(String number) async {
    const path = 'https://auth.foodnet.co.in/api/v1/otp';

    final Map<String, dynamic> body = {
      "app_name": "CONSUMER",
      "username": number,
      "tenantId": 1,
      "usage": "registration"
    };

    final response = await apiClient.post(path, body);
    print('===========================');
    print(response);
    final bool status = response['status'];

    if (status) {
      final dynamic otp = response['otp'];
      print('Saving OTP in sharedPreferences');
      PreferenceManager.setOtpNumber(
          otp.toString()); // Store the otp number in the preference manager
      ToastMessage.showMessage(
          PreferenceManager.getOtpNumber()!); //Toast the OTP number
    }
    return status ? response : {};
  }
}

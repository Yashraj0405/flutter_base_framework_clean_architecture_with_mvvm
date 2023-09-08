import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

import '../../../../app/preference_manager.dart';

class ValidateOtpApi {
  final ApiClient apiClient;
  ValidateOtpApi(this.apiClient);

  Future<Map<String, dynamic>> validateOtp(String otp) async {
    const path =
        "https://jaspurauthuat.skandhanetworks.com/api/v1/validate_otp";

    final Map<String, dynamic> body = {
      "tenantId": 1,
      "app_name": "JASPURBO",
      "username": PreferenceManager.getEmail(),
      "otp": otp,
    };
    final response = await apiClient.post(path, body);
    bool status = response['status'];
    return status ? response : {};
  }
}

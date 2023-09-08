import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

import '../../../../presentation/manager/constant/toast_constant.dart';

class VerifyUsernameExistsApi {
  final ApiClient apiClient;
  VerifyUsernameExistsApi(this.apiClient);

  Future<Map<String, dynamic>> VerifyEmail(String email) async {
    const path =
        "https://jaspurauthuat.skandhanetworks.com/api/v1/username-exist";
    final Map<String, dynamic> body = {
      "email": email,
    };

    final response = await apiClient.post(path, body);
    bool status = response['status'];
    if (status) {
      const path = "https://jaspurauthuat.skandhanetworks.com/api/v1/otp";
      final Map<String, dynamic> body = {
        "app_name": "JASPURBO",
        "username": email,
        "email": email,
        "usage": "login"
      };
      final response = await apiClient.post(path, body);
      bool status = response['status'];
      if (status) {
        ToastMessage.showMessage(response['otp'].toString());
      }
    }
    return status ? response : {};
  }
}

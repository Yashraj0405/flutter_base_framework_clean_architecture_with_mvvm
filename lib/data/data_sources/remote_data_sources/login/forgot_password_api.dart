import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/constant/toast_constant.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';
import 'package:http/http.dart';

class ForgotPasswordApi {
  final ApiClient apiClient;

  ForgotPasswordApi(this.apiClient);

  Future<Map<String, dynamic>> forgotPassword(
    String email,
    String newPassword,
    String confirmPassword,
  ) async {
    const path =
        'https://jaspurauthdev.skandhanetworks.com/api/v1/forgotpassword';

    final Map<String, dynamic> body = {
      "email": email,
      "appName": "JASPURBO",
      "newPassword": newPassword,
      "confirmNewPassword": confirmPassword,
    };

    final response = await apiClient.post(path, body);
    print(response);
    bool status = response['status'];
    if (status) {
      ToastMessage.showMessage("Pasword Changed Successfully");
    }
    PreferenceManager.setMessage(response['message'].toString());

    return status ? response : {};
  }

  // Future<Map<String, dynamic>> VerifyEmail(String email) async {
  //   const path =
  //       "https://jaspurauthuat.skandhanetworks.com/api/v1/username-exist";
  //   final Map<String, dynamic> body = {
  //     "email": email,
  //   };

  //   final response = await apiClient.post(path, body);
  //   bool status = response['status'];
  //   if (status) {
  //     const path = "https://jaspurauthuat.skandhanetworks.com/api/v1/otp";
  //     final Map<String, dynamic> body = {
  //       "app_name": "JASPURBO",
  //       "username": email,
  //       "email": email,
  //       "usage": "login"
  //     };
  //     final response = await apiClient.post(path, body);
  //     bool status = response['status'];
  //     if (status) {
  //       ToastMessage.showMessage(response['otp'].toString());
  //     }
  //   }
  //   return status ? response : {};
  // }

  // Future<Map<String, dynamic>> ValidateOtp(String otp) async {
  //   const path =
  //       "https://jaspurauthuat.skandhanetworks.com/api/v1/validate_otp";
        
  //   final Map<String, dynamic> body = {
  //     "tenantId": 1,
  //     "app_name": "JASPURBO",
  //     "username": PreferenceManager.getEmail(),
  //     "otp": otp,
  //   };
  //   final response = await apiClient.post(path, body);
  //   bool status = response['status'];
  //   return status ? response : {};
  // }
}

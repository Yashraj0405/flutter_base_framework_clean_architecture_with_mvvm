import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/constant/toast_constant.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

class SignUpApi {
  final ApiClient apiClient;
  SignUpApi(this.apiClient);

  Future<Map<String, dynamic>> createUserUsingEmail(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String password,
    String otp,
  ) async {
    const path =
        "https://jaspurregistrationdev.skandhanetworks.com/api/v1/registration";
    final Map<String, dynamic> body = {
      "registerType": "Affiliate",
      "appName": "JASPURBO",
      "email": email,
      "pwd": password,
      "otp": otp,
      "affiliate": {
        "affiliate_name": "${firstName}Demo",
        "affiliate_logo":
            "https://tims-assets.s3.ap-south-1.amazonaws.com/assets/product_images/Hot-Beverages/HotBeverages_01_Latte.png"
      },
      "media": {
        "media_name": "Demo",
        "media_logo":
            "https://tims-assets.s3.ap-south-1.amazonaws.com/assets/product_images/Hot-Beverages/HotBeverages_01_Latte.png"
      },
      "contact": {
        "type": "Affiliate",
        "title": "${firstName}Demo",
        "prefix": "Mr",
        "first_name": firstName,
        "middle_name": "",
        "surname": lastName,
        "postfix": "",
        "phone_1": contactNo,
        "phone_2": ""
      },
      "address": {
        "line_1": "sdfsdaf asdasdasd",
        "line_2": null,
        "line_3": null,
        "line_4": null,
        "line_5": null,
        "village_town_city": "Abbeville",
        "country": "United States of America",
        "state": "Colorado",
        "zip_post_code": "56748"
      }
    };

    final response = await apiClient.post(path, body);
    print(response);
    final bool status = response['status'];
    print(status);
    if (status) {
      ToastMessage.showMessage("Account Created Successfully");
    }

    return status ? response : {};
  }
}

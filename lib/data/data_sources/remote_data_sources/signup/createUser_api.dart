import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';

class CreateUserApi {
  final ApiClient apiClient;

  CreateUserApi(this.apiClient);

  Future<Map<String, dynamic>> createUser(
    String firstName,
    String lastName,
    String email,
    String contactNo,
    String otp,
  ) async {
    const path =
        'https://consumer.foodnet.co.in/api/v1/explore/consumer_registration/consumer';

    final Map<String, dynamic> body = {
      "partyTypeId": "Person",
      "email": email,
      "mobile": contactNo,
      "tenantId": "1",
      "accepted_terms_condition": true,
      "person": {
        "first_name": firstName,
        "last_name": lastName,
        "tenantId": "1"
      },
      "user_login": {
        "tenantId": "1",
        "app_name": "CONSUMER",
        "email": email,
        "mobile": contactNo,
        "username": contactNo,
        "otp": otp
      },
      "phones": [
        {
          "tenantId": "1",
          "phone_number": contactNo,
          "phoneTypeId": 1,
          "is_primary": true
        }
      ]
    };

    final response = await apiClient.post(path, body);
    print(response);
    final bool status = response['status'];

    return status ? response : {};
  }
}

import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';

import '../../../../presentation/manager/network/api_client.dart';

class AuthenticationApi {
  final ApiClient apiClient;

  // Constructor to inject the ApiClient instance
  AuthenticationApi(this.apiClient);

  // Constructor to inject the ApiClient instance
  Future<Map<String, dynamic>> loginUser(
    String username,
    String password,
  ) async {
    // Define the API endpoint path
    const path =
        'https://jaspurserverdev.skandhanetworks.com/admin/api/v1/login';

    // Create the request body
    final Map<String, dynamic> body = {
      'app_name': 'JASPURBO',
      'username': username,
      'password': password,
    };

    // Send a POST request using the apiClient
    final response = await apiClient.post(path, body);
    // Check if the login was successful
    final bool success = response['status'];
    if (success) {
      PreferenceManager.setLoggedIn(success);
      PreferenceManager.setEmail(username);
      final accessToken = response["accessToken"];
      PreferenceManager.setAccessToken(
          accessToken); // Store the access token in the preferences manager
    }
    print(PreferenceManager.isLoggedIn().toString());
    return success ? response : {}; // Return the API response
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  // Constructor to initialize the base URL for the API.
  ApiClient(this.baseUrl);

  // Performs an HTTP POST request.
  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print(path);
      print(body);

      return _handleResponse(response);
    } catch (e) {
      print(e);
    }
    return {};
  }

  // Handles the HTTP response.
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('--------------------------------');
      print(response.body);

      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Request failed with status: ${response.statusCode} ${response.body}");
    }
  }
}

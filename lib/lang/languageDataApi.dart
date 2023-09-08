import 'dart:convert';

import 'package:http/http.dart' as http;
import 'languageDataModel.dart';

class MultilanguageDataAPI {
  final httpClient = http.Client();

  final baseUrl = "https://5z674.wiremockapi.cloud/multi/language";
  Future<LanguageData> fetchLanguageData() async {
    final response = await httpClient.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final body = response.body;
      final languageData = jsonDecode(body);
      print(languageData);
      return LanguageData.fromJson(languageData);
    } else {
      throw Exception("Failed to fetch language data");
    }
  }

//   Future<LanguageData> fetchLanguages() async {
//   var response = await httpClient.get(Uri.parse(baseUrl));
  
//   if (response.statusCode == 200) {
//     return LanguageData.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to fetch languages');
//   }
// }
}

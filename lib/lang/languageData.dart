import 'languageDataApi.dart';
import 'languageDataModel.dart';

class LanguageDataManager {
  // Private constructor prevents instantiation from outside.
  LanguageDataManager._();

  // Instance of LanguageData for managing language data.
  static LanguageData? languageData;

  // Static selectedLanguage variable
  static String selectedLanguage = '';

  // Get Translations
  static String getTranslation(String key) {
    return languageData?.language[selectedLanguage]?[key] ?? '';
  }

  // Fetches and initializes the LanguageData instance.
  static Future<LanguageData> fetchData() async {
    if (languageData != null) {
      return languageData!;
    }

    try {
      final data = await MultilanguageDataAPI().fetchLanguageData();
      languageData = data;
      return data;
    } catch (e) {
      // Handle error
      languageData = LanguageData(
          language: {}); // Return a default value or handle the error gracefully
      return languageData!;
    }
  }
}

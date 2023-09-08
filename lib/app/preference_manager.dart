import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/constant/key_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Singleton class responsible for managing shared preferences.
class PreferenceManager {
  // Private constructor prevents instantiation from outside.
  PreferenceManager._();

  // Instance of SharedPreferences for managing preferences.
  static SharedPreferences? _preferences;

  // Initializes the SharedPreferences instance.
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Sets the access token in shared preferences.
  static void setAccessToken(String data) {
    _preferences!.setString(KeyName.accessToken, data);
  }

  // Retrieves the access token from shared preferences.
  static String? getAccessToken() {
    return _preferences!.getString(KeyName.accessToken);
  }

  // Sets the refresh token in shared preferences.
  static void setRefreshToken(String data) {
    _preferences!.setString(KeyName.refreshToken, data);
  }

  // Retrieves the refresh token from shared preferences.
  static String? getRefreshToken() {
    return _preferences!.getString(KeyName.refreshToken);
  }

  // Sets the contact number in shared preferences.
  static void setContactNumber(String data) {
    _preferences!.setString(KeyName.contactNumber, data);
  }

  // Retrieves the contact number from shared preferences.
  static String? getContactNumber() {
    return _preferences!.getString(KeyName.contactNumber);
  }

  // Sets the otp number in shared preferences.
  static void setOtpNumber(String data) {
    _preferences!.setString(KeyName.Otp, data);
  }

  // Retrieves the otp number from shared preferences.
  static String? getOtpNumber() {
    return _preferences!.getString(KeyName.Otp);
  }

  static String? setEmail(String data) {
    _preferences!.setString(KeyName.email, data);
  }

  static String? getEmail() {
    return _preferences!.getString(KeyName.email);
  }

  static String? setMessage(String data) {
    _preferences!.setString(KeyName.message, data);
  }

  static String? getMessage() {
    return _preferences!.getString(KeyName.message);
  }

  static bool? setLoggedIn(bool data) {
    _preferences!.setBool(KeyName.IS_LOGGED_IN, data);
  }

  static bool isLoggedIn() =>
      _preferences!.getBool(KeyName.IS_LOGGED_IN) ?? false;
}

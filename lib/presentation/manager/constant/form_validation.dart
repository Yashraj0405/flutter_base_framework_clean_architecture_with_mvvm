import 'package:get/get.dart';

class FormValidation {
  //Email VAlidation

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      //return 'Please enter an email address';
      return "pleaseEnterAnEmailAddress".tr;
    }

    bool emailValid =
        RegExp(r'^[a-z][\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);

    if (!emailValid) {
      //return 'Please enter a valid email address with lowercase first letter';
      return "pleaseEnteraValidEmailAddressWithLowercaseFirstLetter".tr;
    }

    return null; // Return null if the validation is successful.
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      //return 'Please enter a first name';
      return "pleaseEnteraFirstName".tr;
    }

    if (value.length < 3) {
      //return 'First name must be at least 3 characters long';
      return 'firstNameMustBeAtLeast3CharactersLong'.tr;
    }

    if (!RegExp(r'^[A-Z][a-zA-Z]*$').hasMatch(value)) {
      //return 'First name should start with a capital letter';
      return 'firstNameShouldStartWithaCapitalLetter'.tr;
    }

    return null; // Return null if the validation is successful.
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      //return 'Please enter a last name';
      return 'pleaseEnteraLastName'.tr;
    }

    if (value.length < 3) {
      return 'lastNameMustBeAtLeast3CharactersLong'.tr;
    }

    if (!RegExp(r'^[A-Z][a-zA-Z]*$').hasMatch(value)) {
      //return 'Last name should start with a capital letter';
      return 'LastNameShouldStartWithaCapitalLetter'.tr;
    }

    return null; // Return null if the validation is successful.
  }

//Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      //return 'Please enter a password';
      return 'pleaseEnteraPassword'.tr;
    }
    if (value.length < 6) {
      //return 'Password must be at least 6 characters long';
      return 'passwordMustBeAtLeast6CharactersLong'.tr;
    }
    return null; // Return null if the validation is successful.
  }

  //Contact Number Validation
  static String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      //return 'Please enter a contact number';
      return 'pleaseEnteraContactNumber'.tr;
    }
    if (value.length != 10) {
      //return 'Please enter a valid 10-digit contact number';
      return 'pleaseEnteraValid10-digitContactNumber'.tr;
    }
    return null; // Return null if the validation is successful.
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      // return 'Please enter  OTP number';
      return 'pleaseEnterOTPNumber'.tr;
    }
    if (value.length != 4) {
      //return 'Please enter a 4-digit OTP number';
      return 'pleaseEntera4-digitOTPNumber'.tr;
    }
    return null; // Return null if the validation is successful.
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    if (!containsUppercase(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!containsLowercase(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!containsDigit(value)) {
      return 'Password must contain at least one digit';
    }
    if (!containsSpecialCharacter(value)) {
      return 'Password must contain at least one special character (!@#\$%^&*_)';
    }
    return null; // Return null if the validation is successful.
  }

  static bool containsUppercase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  static bool containsLowercase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  static bool containsDigit(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  static bool containsSpecialCharacter(String value) {
    return value.contains(RegExp(
        r'[!@#\$%^&*_)\\-]')); // Escape the hyphen inside the character class
  }
}

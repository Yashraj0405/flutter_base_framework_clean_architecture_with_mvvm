import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  // Displays a toast message with the given message.
  static void showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colormanager.white,
      textColor: Colormanager.black,
      fontSize: FontSize.textSize16,
    );
  }
}

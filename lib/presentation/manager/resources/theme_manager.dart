
import 'package:flutter/material.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/styles_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //Main Colors of the applications
    primaryColor: Colormanager.primary,
    primaryColorLight: Colormanager.primaryOpacity70,
    primaryColorDark: Colormanager.darkGrey,
    disabledColor: Colormanager.grey1,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colormanager.grey,
    ),
    splashColor: Colormanager.primaryOpacity70,

    //CardView Theme
    cardTheme: CardTheme(
      color: Colormanager.white,
      shadowColor: Colormanager.grey,
      elevation: AppSize.s4,
    ),

    // Appbar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colormanager.primary,
      elevation: AppSize.s4,
      shadowColor: Colormanager.primaryOpacity70,
      titleTextStyle: getRegularStyle(
        color: Colormanager.white,
        fontSize: FontSize.textSize16,
      ),
    ),

    //Buttom Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: Colormanager.grey1,
      buttonColor: Colormanager.primary,
      splashColor: Colormanager.primaryOpacity70,
    ),

    //Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: Colormanager.white,
        ),
        foregroundColor: Colormanager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    //Text Theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
        color: Colormanager.darkGrey,
        fontSize: FontSize.textSize16,
      ),
      titleMedium: getMediumStyle(
        color: Colormanager.lightGrey,
        fontSize: FontSize.textSize14,
      ),
      bodySmall: getRegularStyle(
        color: Colormanager.grey1,
      ),
      bodyLarge: getRegularStyle(
        color: Colormanager.grey,
      ),
    ),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: Colormanager.grey1),
      labelStyle: getMediumStyle(color: Colormanager.darkGrey),
      errorStyle: getRegularStyle(color: Colormanager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colormanager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colormanager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colormanager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colormanager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}

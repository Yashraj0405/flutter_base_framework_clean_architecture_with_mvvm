import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/value_manager.dart';

class Style {
  //Returns a Text widget with a light style
  static Widget getLightText(
    String text,
    double size,
    Color color, {
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 1,
    bool? softWrap = false,
  }) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: getLightStyle(
        color: color,
        fontSize: size,
      ),
    );
  }

  //Returns a Text widget with a bold style
  static Widget getBoldText(
    String text,
    double size,
    Color color, {
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 1,
    bool? softWrap = false,
  }) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: getBoldStyle(
        color: color,
        fontSize: size,
      ),
    );
  }

// Returns a Text widget with a medium style
  static Widget getMediumText(
    String text,
    double size,
    Color color, {
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 1,
    bool? softWrap = false,
  }) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: getMediumStyle(
        color: color,
        fontSize: size,
      ),
    );
  }

// Returns a Text widget with a semi-bold style
  static Widget getSemiBoldText(
    String text,
    double size,
    Color color, {
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 1,
    bool? softWrap = false,
  }) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: getSemiBoldStyle(
        color: color,
        fontSize: size,
      ),
    );
  }

  // Returns a Text widget with a regular style
  static Widget getRegularText(
    String text,
    double size,
    Color color, {
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 1,
    bool? softWrap = false,
  }) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: getRegularStyle(
        color: color,
        fontSize: size,
      ),
    );
  }

// Returns a TextButton widget with specified attributes
  static Widget getTextButton(
    double width,
    double height,
    String btnName, {
    //Function onClick,
    Function? onClick,
    bool showBorder = true,
    double borderRadius = 25,
    Color? borderColor,
    double padding = AppPadding.p6,
  }) {
    final finalBorderColor = borderColor ?? Colormanager.darkGrey;
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        child: InkWell(
          borderRadius: BorderRadius.circular(height / 2),
          onTap: () {
            onClick!.call();
          },
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: showBorder
                  ? Border.all(color:  finalBorderColor, width: 1)
                  : const Border(),
            ),
            child: Center(
              child: getSemiBoldText(
                btnName,
                FontSize.textSize18,
                Colormanager.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

// Returns a GestureDetector wrapped TextButton widget with elevation
  static Widget getTextBtnWithElevation(
    String btnName,
    //Function onTap, {
    Function()? onTap, {
    double? width,
    double height = 50,
    double textSize = FontSize.textSize18,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.p2),
        child: Material(
          elevation: 1.0,
          color: Colormanager.white,
          shadowColor: Colormanager.darkGrey.withOpacity(.4),
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(AppPadding.p6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              border: Border.all(
                color: Colormanager.indigoAccent.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Center(
              child: getSemiBoldText(
                btnName,
                FontSize.textSize16,
                Colormanager.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

// Returns a Card widget with a border and given attributes
  static Widget getCardViewWithBorder(
      double? elevation, Color color, double borderWidth, Widget widget) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: color,
          width: borderWidth,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: widget,
      ),
    );
  }


  
  // Returns a text input field widget with specified attributes
  static Widget getTextinputField(
    String hintName, {
    double height = 45,
    TextEditingController? controller,
    Function(String)? onChange,
    TextInputType inputType = TextInputType.text,
    TextInputAction inputAction = TextInputAction.next,
    EdgeInsets? margin,
    int? maxLength,
    bool showBorder = false,
    bool obscureText = false,
    double borderRadius = 10,
    List<TextInputFormatter>? textInputFormatter,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return Container(
      height: height,
      margin: margin,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        textAlign: TextAlign.start,
        onChanged: onChange,
        maxLength: maxLength,
        style: getMediumStyle(
          fontSize: FontSize.textSize18,
          color: Colormanager.darkGrey,
        ),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide: BorderSide(
                    color: Colormanager.grey1,
                    width: 0.5,
                  ),
                )
              : InputBorder.none,
          focusedBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide:
                      BorderSide(color: Colormanager.darkGrey, width: 0.5),
                )
              : InputBorder.none,
          hintText: hintName,
          hintStyle: getLightStyle(
            fontSize: FontSize.textSize14,
            color: Colormanager.lightGrey,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        keyboardType: inputType,
        textInputAction: inputAction,
        inputFormatters: textInputFormatter,
      ),
    );
  }
// Returns a text input form field widget with specified attributes
  static Widget getTextFormField(
    String lableText,
    String? hintText, {
    double height = 60,
    EdgeInsets? margin,
    int? maxLength,
    bool showBorder = false,
    bool obscureText = false,
    bool enabled = true,
    TextEditingController? controller,
    TextInputType inputType = TextInputType.text,
    TextInputAction inputAction = TextInputAction.next,
    List<TextInputFormatter>? textInputFormatter,
    String? Function(String?)? validator,
    double borderRadius = 10,
    Widget? sufficIcon,
    Widget? prefixIcon,
  }) {
    return Container(
      height: height,
      margin: margin,
      child: TextFormField(
        enabled: enabled,
        obscureText: obscureText,
        controller: controller,
        maxLength: maxLength,
        validator: validator,
        style: getMediumStyle(
          fontSize: FontSize.textSize18,
          color: Colormanager.darkGrey,
        ),
        keyboardType: inputType,
        textInputAction: inputAction,
        inputFormatters: textInputFormatter,
        decoration: InputDecoration(
          labelText: lableText,
          hintText: hintText,
          hintStyle: getLightStyle(
            fontSize: FontSize.textSize14,
            color: Colormanager.lightGrey,
          ),
          border: showBorder
              ? OutlineInputBorder(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide: BorderSide(
                    color: Colormanager.grey1,
                    width: 0.5,
                  ),
                )
              : InputBorder.none,
          focusedBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius:  BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  borderSide:
                      BorderSide(color: Colormanager.darkGrey, width: 0.5),
                )
              : InputBorder.none,
          suffixIcon: sufficIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  static Widget getTextFormFieldOTP(
    String hintText,
    context, {
    EdgeInsets? margin,
    Function(String)? onChange,
    bool showBorder = false,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return Container(
      height: 68,
      width: 64,
      margin: margin,
      child: TextFormField(
        //maxLength: 1,
        //textInputAction: textInputAction,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          //FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getLightStyle(
            fontSize: FontSize.textSize16,
            color: Colormanager.lightGrey,
          ),
          border: showBorder
              ? OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colormanager.grey1,
                    width: 0.5,
                  ),
                )
              : InputBorder.none,
          focusedBorder: showBorder
              ? OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide:
                      BorderSide(color: Colormanager.darkGrey, width: 0.5),
                )
              : InputBorder.none,
        ),
      ),
    );
  }
}

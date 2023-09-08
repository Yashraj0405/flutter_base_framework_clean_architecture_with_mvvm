import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final double elevation;
  final bool? automaticallyImplLeading;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomAppBar(
    this.name, {
    super.key,
    this.elevation = 1,
    this.automaticallyImplLeading,
    this.leadingWidget,
    this.backgroundColor = Colors.transparent,
    this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: elevation,
      leading: Navigator.canPop(context) ? null : leadingWidget,
      iconTheme: IconThemeData(color: Colormanager.darkGrey),
      title: Style.getLightText(
        name,
        FontSize.textSize16,
        Colormanager.darkGrey,
      ),
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}

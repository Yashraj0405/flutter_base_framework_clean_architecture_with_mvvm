import 'package:flutter/material.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';

import '../manager/resources/app_assets.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<String> items = PreferenceManager.isLoggedIn()
      ? ["Terms & Conditions", "Privacy Policy", "Sign Out"]
      : [
          "Terms & Conditions",
          "Privacy Policy",
        ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colormanager.white,
      height: double.maxFinite,
      child: Builder(builder: (ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _headerView(),
                    const SizedBox(
                      height: 15,
                    ),
                    for (int i = 0; i < items.length; i++)
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Style.getRegularText(
                              items[i],
                              FontSize.textSize16,
                              Colormanager.grey1,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Style.getRegularText(
                              ">",
                              FontSize.textSize16,
                              Colormanager.grey1,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _headerView() {
    return Container(
      color: const Color.fromARGB(255, 24, 27, 56).withOpacity(0.95),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p14,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colormanager.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Style.getLightText(
                  "Menu",
                  16,
                  Colormanager.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Image.asset(
              AppAssets.companyLogo,
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: Center(
              child: Style.getMediumText(
                PreferenceManager.isLoggedIn() ? "User Email :" : "Guest",
                FontSize.textSize16,
                Colormanager.white,
              ),
            ),
            subtitle: Center(
              child: Style.getMediumText(
                PreferenceManager.isLoggedIn()
                    ? "${PreferenceManager.getEmail()} "
                    : "Sign Up/Sign In",
                FontSize.textSize16,
                Colormanager.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

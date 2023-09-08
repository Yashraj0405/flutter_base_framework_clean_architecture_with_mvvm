import 'package:flutter/material.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/lang/languageData.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/lang/languageDataApi.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/routes_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/strings_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/loginScreen/loginScreenT2.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/loginScreen/login_screen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/registrationScreen/registerScreen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/registrationScreen/registerScreenT1.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/registrationScreen/registerScreenT2.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/signupScreen/signup_screen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/signupScreen/signup_screenT2.dart';

import '../../../lang/languageDataModel.dart';
import '../../manager/resources/app_assets.dart';
import '../../widgets/customAppBar.dart';
import '../loginScreen/loginScreenT1.dart';
import 'package:get/get.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final multiLanuageApi = MultilanguageDataAPI();

  //LanguageData languageData = LanguageData(language: {});
  String selectedLanguage = 'hi_IN'; // Default language

  // @override
  // void initState() {
  //   super.initState();
  //   //languageData = LanguageData(language: {});
  //   _fetchLanguageData();
  // }
  // Future<void> _fetchLanguageData() async {
  //   try {
  //     final data = await multiLanuageApi.fetchLanguageData();
  //     setState(() {
  //       languageData = data;
  //     });
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': const Locale('mr', 'IN')},
    {'name': 'ಕನ್ನಡ', 'locale': const Locale('kn', 'IN')},
  ];
  String selectedLocale = "English";

  @override
  Widget build(BuildContext context) {
    final deviceDimension = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colormanager.white,
      appBar: CustomAppBar(
        "",
        elevation: 0,
        backgroundColor: Colormanager.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colormanager.indigoAccent.withOpacity(0.4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton(
                  itemBuilder: (context) {
                    return locale.map((localelang) {
                      return PopupMenuItem(
                        child: Text(localelang['name']),
                        onTap: () {
                          selectedLocale = (localelang['name']).toString();
                          Get.updateLocale(
                            Locale(
                              (localelang['locale']).toString(),
                            ),
                          );
                          selectedLanguage = (localelang['locale']).toString();
                          LanguageDataManager.selectedLanguage =
                              (localelang['locale']).toString();
                        },
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.language_outlined,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Style.getSemiBoldText(
                          selectedLocale.toUpperCase(),
                          FontSize.textSize16,
                          Colormanager.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AppPadding.p18,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppAssets.companyLogo,
                height: deviceDimension.height * 0.2,
                width: deviceDimension.width * 0.9,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Style.getTextButton(
              deviceDimension.width,
              50,
              //AppStrings.signUpText,
              //"signUp".tr,
              borderRadius: 5,
              LanguageDataManager.languageData?.language[selectedLanguage]
                      ?['signUp'] ??
                  '',
              //LanguageDataManager.getTranslation('signUp'),
              onClick: () {
                Navigator.push(
                  context,
                  Routes.createRoute(
                    const RegisterScreenT1(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Style.getSemiBoldText(
                  //AppStrings.alreadyHaveAccount,
                  //"alreadyHaveAnAccount".tr,
                  LanguageDataManager.languageData?.language[selectedLanguage]
                          ?['alreadyHaveAnAccount'] ??
                      '',
                  //Text(signUp),
                  FontSize.textSize16,
                  Colormanager.grey1,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Style.getSemiBoldText(
                    //AppStrings.singinText,
                    "signIn".tr,
                    //languageData.language[selectedLanguage]!['signIn'] ?? '',
                    FontSize.textSize18,
                    Colormanager.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      Routes.createRoute(
                        const LoginScreenT1(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Image.asset(
                AppAssets.landingPageLogo,
                height: deviceDimension.height * 0.25,
                width: deviceDimension.width * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

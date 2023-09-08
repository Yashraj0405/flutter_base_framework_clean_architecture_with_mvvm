import 'package:flutter/material.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/login/forgot_password_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/login/validate_otp_authentication_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/lang/languageData.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_path.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/localString.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/home/home_screen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/landingScreen/landingScreen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/loginScreen/loginScreenT1.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/loginScreen/loginScreenT2.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/loginScreen/login_screen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/otpScreen/otp_screen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/otpScreen/otp_screenT1.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/otpScreen/otp_screenT2.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/registrationScreen/registerScreen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/signupScreen/signup_screen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/signupScreen/signup_screenT1.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/signupScreen/signup_screenT2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'data/data_sources/remote_data_sources/login/authentication_api.dart';
import 'data/data_sources/remote_data_sources/login/otp_authentication_api.dart';
import 'data/repositories/login/authentication_repository_impl.dart';
import 'domain/usecases/login/login_user_usecase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializedAndRun();
}

// Initializes necessary resources and runs the app.
_initializedAndRun() async {
  await PreferenceManager.init(); // Initialize shared preferences.
  await LanguageDataManager.fetchData();
  runApp(const MyApp()); // Run the app.
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) {
        // Create instances of necessary APIs and repositories.
        final authenticationApi = AuthenticationApi(ApiClient(ApiPath.baseUrl));
        final optAuntenticationApi =
            OtpAuthenticationApi(ApiClient(ApiPath.baseUrl));
        final validateOtpAutenticationApi =
            ValidateOtpAutenticationAPi(ApiClient(ApiPath.baseUrl));
        final forgotPasswordApi = ForgotPasswordApi(ApiClient(ApiPath.baseUrl));
        final authenticationRepository = AuthenticationRepositoryImpl(
          authenticationApi,
          optAuntenticationApi,
          validateOtpAutenticationApi,
          forgotPasswordApi,
        );
        // Create and initialize the LoginBloc with the LoginUserUsecase.
        return LoginBloc(
          loginUserUsecase: LoginUserUsecase(authenticationRepository),
        );
      },
      child: GetMaterialApp(

        translations: LocalStrings(),
        locale: const Locale('en','US'),
        debugShowCheckedModeBanner: false,

        home: const LandingScreen(), // Set the initial screen to LoginScreen.
        // routes: {
        //   // Define named routes for navigation.
        //   HomeScreen.routeName: (context) => const HomeScreen(),
        //   LoginScreen.routeName: (context) => const LoginScreen(),
        //   SignUpScreen.routeName: (context) => const SignUpScreen(),
        //   OTPScreen.routeName: (context) => const OTPScreen(),

        //   LoginScreenT1.routeName: (context) => const LoginScreenT1(),
        //   OTPScreenT1.routeName: (context) => const OTPScreenT1(),
        //   SignUpScreenT1.routeName: (context) => const SignUpScreenT1(),

        //   LoginScreenT2.routeName: (context) => const LoginScreenT2(),
        //   OTPScreenT2.routeName: (context) => const OTPScreenT2(),
        //   SignUpScreenT2.routeName: (context) => const SignUpScreenT2(),
        // },
      ),
    );
  }
}

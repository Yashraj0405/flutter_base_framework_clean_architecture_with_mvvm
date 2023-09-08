import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/routes_manager.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/varifyEmailScreen/verifyEmailScreen.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/registrationScreen/registerScreen.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/widgets/customAppBar.dart';

import '../../../app/preference_manager.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../home/home_screen.dart';
import '../otpScreen/otp_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_state.dart';
import '../../manager/constant/form_validation.dart';
import '../../manager/resources/app_assets.dart';
import '../../manager/resources/color_manager.dart';
import '../../manager/resources/font_manager.dart';
import '../../manager/resources/strings_manager.dart';
import '../../manager/resources/value_manager.dart';
import '../../manager/style/style.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Toggle whether to show the password
  bool showPassword = true;
  // Toggle between login with email/password and OTP
  bool loginWithMailPassword = false;

  // Color and icon for password visibility toggle
  Color _iconColor = Colormanager.grey1;
  IconData _visiblityIcon = Icons.visibility_off;

  // GlobalKey to manage and identify the form
  final _formKey = GlobalKey<FormState>();

  // Validation methods for form fields
  String? _validateEmail(String? value) {
    return FormValidation.validateEmail(value);
  }

  String? _validatePassword(String? value) {
    return FormValidation.validatePassword(value);
  }

  String? _validateNumber(String? value) {
    return FormValidation.validateContactNumber(value);
  }

  // Submit the form
  bool _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data here.
      if (loginWithMailPassword) {
        String email = emailController.text;
        print('Valid email: $email');
        return true;
      }
      if (!loginWithMailPassword) {
        String contact = numberController.text;
        print('Valid contact: $contact');
        return true;
      }
      return false; // Default case if neither email/password nor OTP
    } else {
      return false; // Form is invalid
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceDimension = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colormanager.white,
      appBar: const CustomAppBar("", elevation: 0),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // Listener to handle different login states
          if (state is LoginFailure) {
            // Show a SnackBar if login fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is LoginSuccess) {
            // Navigate to the home screen on successful login
            Navigator.push(context, Routes.createRoute(const HomeScreen()));
          } else if (state is OtpSuccess) {
            // Navigate to the OTP screen on successful OTP request
            //Navigator.pushNamed(context, OTPScreen.routeName);
            Navigator.push(context, Routes.createRoute(const OTPScreen()));
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            // Show a loading indicator while login is in progress
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Build the login form
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p20,
                  right: AppMargin.m20,
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo
                      Center(
                        child: Image.asset(
                          AppAssets.companyLogo,
                          height: deviceDimension.height * 0.2,
                          width: deviceDimension.width * 0.9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      // Title and subtitle
                      Style.getSemiBoldText(
                        AppStrings.singinText,
                        FontSize.textSize25,
                        Colormanager.black,
                      ),
                      Style.getSemiBoldText(
                        AppStrings.loginSubText,
                        FontSize.textSize18,
                        Colormanager.lightGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Card with input fields
                      Style.getCardViewWithBorder(
                        5,
                        Colormanager.indigoAccent.withOpacity(0.4),
                        1,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            // Email input (visible if loginWithMailPassword)
                            if (loginWithMailPassword)
                              Style.getTextFormField(
                                AppStrings.textEmail,
                                AppStrings.textEmailHint,
                                validator: _validateEmail,
                                margin: const EdgeInsets.all(5),
                                showBorder: true,
                                controller: emailController,
                                inputType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.mail_outline),
                                textInputFormatter: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s'))
                                ],
                              ),
                            // Password input (visible if loginWithMailPassword)
                            if (loginWithMailPassword)
                              Style.getTextFormField(
                                AppStrings.textPassword,
                                AppStrings.textPasswordHint,
                                obscureText: showPassword,
                                validator: _validatePassword,
                                margin: const EdgeInsets.all(5),
                                showBorder: true,
                                controller: passwordController,
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.done,
                                prefixIcon: const Icon(Icons.password_outlined),
                                textInputFormatter: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  )
                                ],
                                sufficIcon: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        showPassword = !showPassword;
                                        _iconColor = showPassword
                                            ? Colormanager.grey1
                                            : Colormanager.indigoAccent;
                                        _visiblityIcon = (showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility);
                                      },
                                    );
                                  },
                                  child: Icon(
                                    _visiblityIcon,
                                    color: _iconColor,
                                  ),
                                ),
                              ),
                            // Contact input (visible if not loginWithMailPassword)
                            if (!loginWithMailPassword)
                              Style.getTextFormField(
                                AppStrings.textContact,
                                AppStrings.textContactNumberHint,
                                controller: numberController,
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.done,
                                validator: _validateNumber,
                                showBorder: true,
                                maxLength: 10,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'),
                                  )
                                ],
                                margin: const EdgeInsets.all(
                                  AppPadding.p6,
                                ),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Toggle between login modes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                loginWithMailPassword = !loginWithMailPassword;
                              });
                            },
                            child: Center(
                              child: Style.getBoldText(
                                loginWithMailPassword
                                    ? AppStrings.signinWithOtp
                                    : AppStrings.signInWithMailPassword,
                                FontSize.textSize16,
                                Colormanager.grey1,
                              ),
                            ),
                          ),
                          if (loginWithMailPassword)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    Routes.createRoute(
                                        const VerifyEmailScreen()));
                              },
                              child: Style.getBoldText(
                                "Forgot Password ?",
                                FontSize.textSize16,
                                Colormanager.grey1,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: deviceDimension.height * 0.2,
                      ),
                      Center(
                        child: Style.getTextButton(
                          deviceDimension.width ,
                          50,
                          loginWithMailPassword
                              ? AppStrings.loginText
                              : AppStrings.getOtpText,
                          onClick: loginWithMailPassword
                              ? () {
                                  bool isValid = _submitForm();
                                  if (isValid) {
                                    context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  }
                                }
                              : () {
                                  bool isValid = _submitForm();
                                  if (isValid) {
                                    PreferenceManager.setContactNumber(
                                        numberController.text);
                                    context.read<LoginBloc>().add(
                                          GetOTPButtonPressed(
                                            contactNumber:
                                                numberController.text,
                                          ),
                                        );
                                  }
                                },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Style.getSemiBoldText(
                            AppStrings.dontHaveAccountText,
                            FontSize.textSize18,
                            Colormanager.grey1,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                Routes.createRoute(
                                  const RegistrationScreen(),
                                ),
                              );
                            },
                            child: Style.getSemiBoldText(
                              AppStrings.signUpText,
                              FontSize.textSize18,
                              Colormanager.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/app_assets.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/routes_manager.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/varifyEmailScreen/verifyEmailScreenT1.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/registrationScreen/registerScreenT1.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/widgets/customAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../app/preference_manager.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../manager/constant/form_validation.dart';
import '../home/home_screen.dart';
import '../otpScreen/otp_screenT1.dart';

class LoginScreenT1 extends StatefulWidget {
  static const routeName = 'LofinScreenT1';
  const LoginScreenT1({super.key});

  @override
  State<LoginScreenT1> createState() => _LoginScreenT1State();
}

class _LoginScreenT1State extends State<LoginScreenT1> {
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
            //Navigator.pushNamed(context, HomeScreen.routeName);
            Navigator.push(
              context,
              Routes.createRoute(
                const HomeScreen(),
              ),
            );
          } else if (state is OtpSuccess) {
            // Navigate to the OTP screen on successful OTP request
            //Navigator.pushNamed(context, OTPScreenT1.routeName);
            Navigator.push(
              context,
              Routes.createRoute(
                const OTPScreenT1(),
              ),
            );
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
                padding: const EdgeInsets.all(AppMargin.m20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          AppAssets.t1login,
                          height: deviceDimension.height * 0.3,
                          width: deviceDimension.width * 0.9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Style.getSemiBoldText(
                        //AppStrings.singinText,
                        "signIn".tr,
                        FontSize.textSize25,
                        Colormanager.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Email input (visible if loginWithMailPassword)
                      if (loginWithMailPassword)
                        Style.getTextFormField(
                          // AppStrings.textEmail,
                          // AppStrings.textEmailHint,
                          "email".tr,
                          "enterRegisteredEmailId".tr,
                          validator: _validateEmail,
                          borderRadius: 5,
                          showBorder: true,
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          sufficIcon: const Icon(Icons.mail_outline),
                          textInputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s'))
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Password input (visible if loginWithMailPassword)
                      if (loginWithMailPassword)
                        Style.getTextFormField(
                          // AppStrings.textPassword,
                          // AppStrings.textPasswordHint,
                          "password".tr,
                          "enterPassword".tr,
                          obscureText: showPassword,
                          validator: _validatePassword,
                          borderRadius: 5,
                          showBorder: true,
                          controller: passwordController,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.done,
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
                                      : Colormanager.grey1;
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
                      const SizedBox(
                        height: 10,
                      ),
                      // Contact input (visible if not loginWithMailPassword)
                      if (!loginWithMailPassword)
                        Style.getTextFormField(
                          //AppStrings.textContact,
                          //AppStrings.textContactNumberHint,
                          "contactNo".tr,
                          "enterContactNo".tr,
                          height: 80,
                          controller: numberController,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.done,
                          validator: _validateNumber,
                          showBorder: true,
                          borderRadius: 5,
                          maxLength: 10,
                          sufficIcon: const Icon(Icons.phone_outlined),
                          textInputFormatter: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            )
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
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
                                    //? AppStrings.signinWithOtp
                                    // : AppStrings.signInWithMailPassword,
                                    ? "signInWithOTP".tr
                                    : "signInWithEmail&Password".tr,
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
                                        const VerifyEmailScreenT1()));
                              },
                              child: Style.getBoldText(
                                //AppStrings.forgotPasswordtext,
                                "forgotPassword".tr,
                                FontSize.textSize16,
                                Colormanager.grey1,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: deviceDimension.height * 0.15,
                      ),

                      // Login button
                      Center(
                        child: Style.getTextButton(
                          deviceDimension.width,
                          50,
                          loginWithMailPassword
                              // ? AppStrings.loginText
                              //: AppStrings.getOtpText,
                              ? "signIn".tr
                              : "getOTP".tr,
                          borderRadius: 5,
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
                            //AppStrings.dontHaveAccountText,
                            "don'tHaveAnAccount".tr,
                            FontSize.textSize16,
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
                                  const RegisterScreenT1(),
                                ),
                              );
                            },
                            child: Style.getSemiBoldText(
                              //AppStrings.signUpText,
                              "signUp".tr,
                              FontSize.textSize16,
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

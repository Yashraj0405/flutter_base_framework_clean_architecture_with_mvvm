import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_state.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/constant/toast_constant.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/strings_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../manager/constant/form_validation.dart';
import '../../manager/resources/app_assets.dart';
import '../../manager/resources/routes_manager.dart';
import '../../widgets/customAppBar.dart';
import '../home/home_screen.dart';
import '../loginScreen/loginScreenT1.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // GlobalKey to manage and identify the form
  final _formKey = GlobalKey<FormState>();
  // Toggle whether to show the password
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  // Color and icon for password visibility toggle
  Color _iconColor = Colormanager.grey1;
  IconData _newvisiblityIcon = Icons.visibility_off;
  IconData _confirmvisiblityIcon = Icons.visibility_off;

  String? _validatePassword(String? value) {
    return FormValidation.validatePassword(value);
  }

  bool _submitForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
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
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is ForgotPasswordSuccess) {
            Navigator.push(
              context,
              Routes.createRoute(
                const LoginScreenT1(),
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
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset(
                      //   AppAssets.t1forgotPassword,
                      //   height: deviceDimension.height * 0.2,
                      //   width: deviceDimension.width * 0.9,
                      //   fit: BoxFit.fitWidth,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Style.getSemiBoldText(
                        AppStrings.forgotPassword,
                        FontSize.textSize25,
                        Colormanager.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Style.getTextFormField(
                        AppStrings.textNewPassword,
                        AppStrings.textNewPasswordHint,
                        obscureText: showNewPassword,
                        validator: _validatePassword,
                        showBorder: true,
                        controller: newPasswordController,
                        inputType: TextInputType.emailAddress,
                        textInputFormatter: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'\s'),
                          )
                        ],
                        sufficIcon: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                showNewPassword = !showNewPassword;
                                _iconColor = showNewPassword
                                    ? Colormanager.grey1
                                    : Colormanager.grey1;
                                _newvisiblityIcon = (showNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility);
                              },
                            );
                          },
                          child: Icon(
                            _newvisiblityIcon,
                            color: _iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Style.getTextFormField(
                        AppStrings.textConfirmNewPassword,
                        AppStrings.textConfrimNewPasswordHint,
                        obscureText: showConfirmPassword,
                        validator: _validatePassword,
                        showBorder: true,
                        controller: confirmPasswordController,
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
                                showConfirmPassword = !showConfirmPassword;
                                _iconColor = showConfirmPassword
                                    ? Colormanager.grey1
                                    : Colormanager.grey1;
                                _confirmvisiblityIcon = (showConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility);
                              },
                            );
                          },
                          child: Icon(
                            _confirmvisiblityIcon,
                            color: _iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: deviceDimension.height * 0.5,
                      ),
                      Center(
                        child: Style.getTextButton(
                          deviceDimension.width,
                          50,
                          AppStrings.submitText,
                          onClick: () {
                            bool isValide = _submitForm();
                            if (isValide) {
                              if (newPasswordController.text ==
                                  confirmPasswordController.text) {
                                context.read<LoginBloc>().add(
                                      SubmitButtomPressed(
                                        email: PreferenceManager.getEmail()
                                            .toString(),
                                        newPassword: newPasswordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                      ),
                                    );
                              } else {
                                ToastMessage.showMessage(
                                    "New Password & Confirm Password should be same!");
                              }
                            }
                          },
                        ),
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

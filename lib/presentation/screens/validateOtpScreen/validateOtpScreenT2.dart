import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/routes_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/forgotScreen/forgotPasswordScreenT2.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/signupScreen/signup_screenT2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
import '../../../data/data_sources/remote_data_sources/verify&validate/validateOtpApi.dart';
import '../../../data/data_sources/remote_data_sources/verify&validate/verifyContact_api.dart';
import '../../../data/data_sources/remote_data_sources/verify&validate/verifyUsernameExistsApi.dart';
import '../../../data/repositories/verify&validate/verify&validate_repository_impl.dart';
import '../../../domain/usecases/verify&validate/verify&validate_usecase.dart';

import '../../bloc/verify&validation/verifyValidate_bloc.dart';
import '../../bloc/verify&validation/verifyValidate_event.dart';
import '../../bloc/verify&validation/verifyValidate_state.dart';
import '../../manager/constant/form_validation.dart';
import '../../manager/constant/toast_constant.dart';
import '../../manager/network/api_client.dart';
import '../../manager/network/api_path.dart';
import '../../manager/resources/color_manager.dart';

import '../../manager/resources/strings_manager.dart';
import '../../manager/style/style.dart';

class ValidateOtpScreenT2 extends StatefulWidget {
  final String source;
  const ValidateOtpScreenT2({
    super.key,
    required this.source,
  });

  @override
  State<ValidateOtpScreenT2> createState() => _ValidateOtpScreenT2State();
}

class _ValidateOtpScreenT2State extends State<ValidateOtpScreenT2> {
  TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _validateOtp(String? value) {
    return FormValidation.validateOtp(value);
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
      // appBar: const CustomAppBar("", elevation: 0),
      // backgroundColor: Colormanager.white,
      body: BlocProvider<VerifyValidateBloc>(
        create: (context) {
          final verifyEmail =
              VerifyUsernameExistsApi(ApiClient(ApiPath.baseUrl));
          final verifyContact = VerifyContactApi(ApiClient(ApiPath.baseUrl));
          final generateOtp = GenerateOtpApi(ApiClient(ApiPath.baseUrl));
          final validateOtp = ValidateOtpApi(ApiClient(ApiPath.baseUrl));
          final verifyValidateRepository = VerifyValidateRepositoryImpl(
            generateOtp,
            validateOtp,
            verifyEmail,
            verifyContact,
          );

          return VerifyValidateBloc(
              verifyValidateUseCase:
                  VerifyValidateUseCase(verifyValidateRepository));
        },
        child: BlocConsumer<VerifyValidateBloc, VerifyValidateState>(
          listener: (context, state) {
            // Listener for changes in the LoginBloc state
            if (state is VerifyValidateFailure) {
              // If the state is LoginFailure, show a SnackBar with the error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is ValidateOtpSuccessState) {
              if (widget.source == "Registration using Email") {
                Navigator.push(
                    context,
                    Routes.createRoute(const SignUpScreenT2(
                      isEmail: true,
                    )));
              } else {
                Navigator.push(context,
                    Routes.createRoute(const ForgotPasswordScreenT2()));
              }
            }
          },
          builder: (context, state) {
            if (state is VerifyValidateLoading) {
              // If the state is LoginLoading, show a CircularProgressIndicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Build the main OTP screen UI when the state is not LoginLoading
              return SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: deviceDimension.height,
                    maxWidth: deviceDimension.width,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colormanager.grey1,
                        Colormanager.black,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Style.getSemiBoldText(
                                "Enter OTP",
                                35,
                                Colormanager.white,
                              ),
                              // Subtitle for OTP screen
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colormanager.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // OTP input field
                                  // Style.getTextinputField(
                                  //   AppStrings.textEnterOtp,
                                  //   height: 60,
                                  //   showBorder: true,
                                  //   borderRadius: 10,
                                  //   maxLength: 4,
                                  //   controller: otpController,
                                  //   inputAction: TextInputAction.done,
                                  //   inputType: TextInputType.number,
                                  // ),
                                  Style.getTextFormField(
                                    "OTP",
                                    AppStrings.textEnterOtp,
                                    height: 80,
                                    controller: otpController,
                                    validator: _validateOtp,
                                    inputType: TextInputType.number,
                                    showBorder: true,
                                    borderRadius: 10,
                                    maxLength: 4,
                                    inputAction: TextInputAction.done,
                                    sufficIcon: const Icon(Icons.pin_outlined),
                                    textInputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  SizedBox(
                                    height: deviceDimension.height * 0.5,
                                  ),
                                  // Validate OTP button
                                  Center(
                                    child: Style.getTextButton(
                                      deviceDimension.width,
                                      50,
                                      "Validate OTP ",
                                      borderRadius: 10,
                                      onClick: () {
                                        bool isValid = _submitForm();
                                        if (isValid) {
                                          if (widget.source ==
                                              "RegistrationScreen") {
                                            if (otpController.text ==
                                                PreferenceManager
                                                    .getOtpNumber()) {
                                              Navigator.push(
                                                context,
                                                Routes.createRoute(
                                                  const SignUpScreenT2(
                                                    isEmail: false,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ToastMessage.showMessage(
                                                  "Invalid OTP");
                                            }
                                          } else {
                                            PreferenceManager.setOtpNumber(
                                                otpController.text);
                                            context
                                                .read<VerifyValidateBloc>()
                                                .add(
                                                  ValidateOtpButtonPressed(
                                                    validateOtp:
                                                        otpController.text,
                                                  ),
                                                );
                                          }
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

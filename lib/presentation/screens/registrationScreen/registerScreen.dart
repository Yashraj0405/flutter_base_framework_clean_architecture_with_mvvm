import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/verifyContact_api.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/verify&validation/verifyValidate_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_path.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/validateOtpScreen/validateOtpScreen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
import '../../../data/data_sources/remote_data_sources/verify&validate/validateOtpApi.dart';
import '../../../data/data_sources/remote_data_sources/verify&validate/verifyUsernameExistsApi.dart';

import '../../../data/repositories/verify&validate/verify&validate_repository_impl.dart';

import '../../../domain/usecases/verify&validate/verify&validate_usecase.dart';

import '../../bloc/verify&validation/verifyValidate_bloc.dart';
import '../../bloc/verify&validation/verifyValidate_state.dart';
import '../../manager/constant/form_validation.dart';
import '../../manager/resources/app_assets.dart';
import '../../manager/resources/color_manager.dart';
import '../../manager/resources/font_manager.dart';
import '../../manager/resources/routes_manager.dart';
import '../../manager/resources/strings_manager.dart';
import '../../manager/resources/value_manager.dart';
import '../../manager/style/style.dart';
import '../../widgets/customAppBar.dart';
import '../loginScreen/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController numberController2 = TextEditingController();

  bool signUpwithEmail = false;

  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    return FormValidation.validateEmail(value);
  }

  String? _validateNumber(String? value) {
    return FormValidation.validateContactNumber(value);
  }

  bool _submitForm() {
    if (_formKey.currentState!.validate()) {
      String contact = numberController.text;
      print('Validating contact : $contact');
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
            if (state is VerifyValidateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is VerifyContactSuccess) {
              Navigator.push(
                  context,
                  Routes.createRoute(const ValidateOtpScreen(
                    source: "RegistrationScreen",
                  )));
            } else if (state is GenerateOtpSuccess) {
              Navigator.push(
                  context,
                  Routes.createRoute(const ValidateOtpScreen(
                    source: "Registration using Email",
                  )));
            }
          },
          builder: (context, state) {
            if (state is VerifyValidateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    right: AppMargin.m20,
                  ),
                  child: Form(
                    key: _formKey,
                    //autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo
                        Center(
                          child: Image.asset(
                            AppAssets.companyLogo,
                            height: deviceDimension.height * 0.17,
                            width: deviceDimension.width * 0.9,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Title and subtitle
                        Style.getSemiBoldText(
                          signUpwithEmail
                              ? AppStrings.emailVerify
                              : AppStrings.contactVarify,
                          FontSize.textSize25,
                          Colormanager.black,
                        ),

                        Style.getSemiBoldText(
                          signUpwithEmail
                              ? AppStrings.EmailotpRegistrationMessage
                              : AppStrings.otpRegistrationMessage,
                          FontSize.textSize18,
                          Colormanager.lightGrey,
                        ),
                        const SizedBox(
                          height: 10,
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
                                height: 10,
                              ),
                              if (!signUpwithEmail)
                                Style.getTextFormField(
                                  AppStrings.textContact,
                                  AppStrings.textContactNumberHint,
                                  controller: numberController,
                                  inputType: TextInputType.number,
                                  inputAction: TextInputAction.done,
                                  validator: _validateNumber,
                                  showBorder: true,
                                  height: 80,
                                  maxLength: 10,
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    )
                                  ],
                                ),
                              if (signUpwithEmail)
                                Style.getTextFormField(
                                  AppStrings.textEmail,
                                  "Enter Email Address",
                                  showBorder: true,
                                  controller: emailController,
                                  validator: _validateEmail,
                                  inputAction: TextInputAction.done,
                                  inputType: TextInputType.emailAddress,
                                  sufficIcon: const Icon(Icons.mail_outline),
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s'))
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //if (signUpwithEmail)
                        InkWell(
                          onTap: () {
                            setState(() {
                              signUpwithEmail = !signUpwithEmail;
                            });
                          },
                          child: Style.getSemiBoldText(
                            signUpwithEmail
                                ? AppStrings.RegisterContact
                                : AppStrings.RegisterEmail,
                            FontSize.textSize18,
                            Colormanager.lightGrey,
                          ),
                        ),

                        SizedBox(
                          height: deviceDimension.height * 0.3,
                        ),
                        Center(
                          child: Style.getTextButton(
                            deviceDimension.width,
                            50,
                            AppStrings.getOtpText,
                            onClick: signUpwithEmail
                                ? () {
                                    bool isValid = _submitForm();
                                    if (isValid) {
                                      PreferenceManager.setEmail(
                                          emailController.text.toString());
                                      context.read<VerifyValidateBloc>().add(
                                          GenerateOtpButtonPressed(
                                              email: emailController.text));
                                    }
                                  }
                                : () {
                                    bool isValid = _submitForm();
                                    if (isValid) {
                                      PreferenceManager.setContactNumber(
                                          numberController.text.toString());
                                      context.read<VerifyValidateBloc>().add(
                                          VerifyContactButtonPressed(
                                              contactNumber:
                                                  numberController.text));
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
                              AppStrings.alreadyHaveAccount,
                              FontSize.textSize18,
                              Colormanager.grey1,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    Routes.createRoute(const LoginScreen()));
                              },
                              child: Style.getSemiBoldText(
                                AppStrings.singinText,
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
      ),
    );
  }
}

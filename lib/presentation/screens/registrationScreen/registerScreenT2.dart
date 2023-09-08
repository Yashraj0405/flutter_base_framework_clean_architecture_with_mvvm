import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/loginScreen/loginScreenT2.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/validateOtpScreen/validateOtpScreenT2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/preference_manager.dart';

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
import '../../manager/network/api_client.dart';
import '../../manager/network/api_path.dart';
import '../../manager/resources/color_manager.dart';
import '../../manager/resources/font_manager.dart';
import '../../manager/resources/routes_manager.dart';
import '../../manager/resources/strings_manager.dart';

import '../../manager/style/style.dart';

class RegisterScreenT2 extends StatefulWidget {
  const RegisterScreenT2({super.key});

  @override
  State<RegisterScreenT2> createState() => _RegisterScreenT2State();
}

class _RegisterScreenT2State extends State<RegisterScreenT2> {
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
                  Routes.createRoute(const ValidateOtpScreenT2(
                    source: "RegistrationScreen",
                  )));
            } else if (state is GenerateOtpSuccess) {
              Navigator.push(
                  context,
                  Routes.createRoute(const ValidateOtpScreenT2(
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
                              Style.getBoldText(
                                signUpwithEmail
                                    ? AppStrings.emailVerify
                                    : AppStrings.contactVarify,
                                40,
                                Colormanager.white,
                              ),
                              Style.getSemiBoldText(
                                  signUpwithEmail
                                      ? AppStrings.EmailotpRegistrationMessage
                                      : AppStrings.otpRegistrationMessage,
                                  FontSize.textSize20,
                                  Colormanager.lightGrey,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  softWrap: false),
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
                                    height: 30,
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
                                      borderRadius: 10,
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
                                      borderRadius: 10,
                                      showBorder: true,
                                      controller: emailController,
                                      validator: _validateEmail,
                                      inputType: TextInputType.emailAddress,
                                      sufficIcon:
                                          const Icon(Icons.mail_outline),
                                      textInputFormatter: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s'))
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 20,
                                  ),
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
                                      FontSize.textSize16,
                                      Colormanager.grey1,
                                    ),
                                  ),

                                  SizedBox(
                                    height: deviceDimension.height * 0.4,
                                  ),
                                  // Login button
                                  Center(
                                    child: Style.getTextButton(
                                      deviceDimension.width,
                                      50,
                                      AppStrings.getOtpText,
                                      borderRadius: 10,
                                      onClick: signUpwithEmail
                                          ? () {
                                              bool isValid = _submitForm();
                                              if (isValid) {
                                                PreferenceManager.setEmail(
                                                    emailController.text
                                                        .toString());
                                                context
                                                    .read<VerifyValidateBloc>()
                                                    .add(
                                                        GenerateOtpButtonPressed(
                                                            email:
                                                                emailController
                                                                    .text));
                                              }
                                            }
                                          : () {
                                              bool isValid = _submitForm();
                                              if (isValid) {
                                                PreferenceManager
                                                    .setContactNumber(
                                                        numberController.text
                                                            .toString());
                                                context
                                                    .read<VerifyValidateBloc>()
                                                    .add(
                                                        VerifyContactButtonPressed(
                                                            contactNumber:
                                                                numberController
                                                                    .text));
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
                                        FontSize.textSize16,
                                        Colormanager.grey1,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.pushNamed(
                                          //     context, SignUpScreenT2.routeName);
                                          Navigator.push(
                                            context,
                                            Routes.createRoute(
                                              const LoginScreenT2(),
                                            ),
                                          );
                                        },
                                        child: Style.getSemiBoldText(
                                          AppStrings.singinText,
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

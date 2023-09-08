import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_state.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/validateOtpScreen/validateOtpScreenT2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../manager/resources/routes_manager.dart';
import '../../manager/resources/strings_manager.dart';
import '../../manager/style/style.dart';

class VerifyEmailScreenT2 extends StatefulWidget {
  const VerifyEmailScreenT2({super.key});

  @override
  State<VerifyEmailScreenT2> createState() => _VerifyEmailScreenT2State();
}

class _VerifyEmailScreenT2State extends State<VerifyEmailScreenT2> {
  // Controllers for the input fields
  TextEditingController emailController = TextEditingController();

  // GlobalKey to manage and identify the form
  final _formKey = GlobalKey<FormState>();

  // Validation methods for form fields
  String? _validateEmail(String? value) {
    return FormValidation.validateEmail(value);
  }

  bool _submitForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false; // Form is invalid
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
            if (state is VerifyValidateFailure) {
              // Show a SnackBar if login fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is VerifyEmailSuccess) {
              // Navigate to the home screen on successful login
              //Navigator.pushNamed(context, HomeScreen.routeName);
              Navigator.push(
                context,
                Routes.createRoute(
                  const ValidateOtpScreenT2(
                    source: "Verify Email",
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is VerifyValidateLoading) {
              // Show a loading indicator while login is in progress
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
                              Style.getSemiBoldText(
                                "Verify Email",
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
                                  Style.getTextFormField(
                                    AppStrings.textEmail,
                                    AppStrings.textEmailHint,
                                    validator: _validateEmail,
                                    borderRadius: 10,
                                    showBorder: true,
                                    controller: emailController,
                                    inputType: TextInputType.emailAddress,
                                    inputAction: TextInputAction.done,
                                    sufficIcon: const Icon(Icons.mail_outline),
                                    textInputFormatter: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'\s'))
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
                                      "Verify Account",
                                      borderRadius: 10,
                                      onClick: () {
                                        final bool isValid = _submitForm();
                                        if (isValid) {
                                          PreferenceManager.setEmail(
                                              emailController.text);
                                          context
                                              .read<VerifyValidateBloc>()
                                              .add(
                                                VerifyEmailButtonPressed(
                                                  verifyEmail:
                                                      emailController.text,
                                                ),
                                              );
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

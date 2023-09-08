import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_bloc.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_state.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/validateOtpScreen/validateOtpScreen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/verify&validate/generateOtp_api.dart';
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
import '../../manager/resources/value_manager.dart';
import '../../manager/style/style.dart';
import '../../widgets/customAppBar.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
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
      appBar: const CustomAppBar("", elevation: 0),
      backgroundColor: Colormanager.white,
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
                  const ValidateOtpScreen(
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
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title for OTP screen
                        Style.getSemiBoldText(
                          "Verify Email",
                          FontSize.textSize20,
                          Colormanager.black,
                        ),
                        Style.getSemiBoldText(
                          AppStrings.forgotPasswordSub,
                          FontSize.textSize18,
                          Colormanager.black,
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        // OTP input field
                        Style.getTextFormField(
                          AppStrings.textEmail,
                          AppStrings.textEmailHint,
                          validator: _validateEmail,
                          showBorder: true,
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.done,
                          sufficIcon: const Icon(Icons.mail_outline),
                          textInputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s'))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        SizedBox(
                          height: deviceDimension.height * 0.55,
                        ),
                        // Validate OTP button
                        Center(
                          child: Style.getTextButton(
                            deviceDimension.width,
                            50,
                            "Verify Account",
                            onClick: () {
                              final bool isValid = _submitForm();
                              if (isValid) {
                                PreferenceManager.setEmail(
                                    emailController.text);
                                context.read<VerifyValidateBloc>().add(
                                      VerifyEmailButtonPressed(
                                        verifyEmail: emailController.text,
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
              );
            }
          },
        ),
      ),
    );
  }
}

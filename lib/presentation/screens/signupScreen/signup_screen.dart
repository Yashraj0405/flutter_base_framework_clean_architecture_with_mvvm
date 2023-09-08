import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/signup/createUser_api.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/repositories/signup/createUser_repository_impl.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/usecases/signup/createUser_usecase.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/signup/signup_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/signup/signup_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/signup/signup_state.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_client.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/network/api_path.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/app_assets.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/routes_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/strings_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/screens/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/preference_manager.dart';
import '../../../data/data_sources/remote_data_sources/signup/signup_api.dart';
import '../../manager/constant/form_validation.dart';
import '../../manager/resources/font_manager.dart';
import '../../widgets/customAppBar.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUuScreen';
  final bool isEmail;
  const SignUpScreen({
    super.key,
    required this.isEmail,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailController2 =
      TextEditingController(text: PreferenceManager.getEmail());
  TextEditingController numberController =
      TextEditingController(text: PreferenceManager.getContactNumber());
  TextEditingController numberController2 = TextEditingController();
  TextEditingController lastNameContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // GlobalKey to manage and identify the form
  final _formKey = GlobalKey<FormState>();
  //Toggle whether to show the password
  bool showPassword = true;

  // Color and icon for password visibility toggle
  Color _iconColor = Colormanager.grey1;
  IconData _visiblityIcon = Icons.visibility_off;

  // Validation methods for form fields
  String? _validateEmail(String? value) {
    return FormValidation.validateEmail(value);
  }

  String? _validateNumber(String? value) {
    return FormValidation.validateContactNumber(value);
  }

  String? _validateFirstName(String? value) {
    return FormValidation.validateFirstName(value);
  }

  String? _validateLastName(String? value) {
    return FormValidation.validateLastName(value);
  }

  String? _validatePassword(String? value) {
    return FormValidation.validateNewPassword(value);
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
      body: BlocProvider<SignUpBloc>(
        create: (context) {
          final createUserApi = CreateUserApi(ApiClient(ApiPath.baseUrl));
          final signUpApi = SignUpApi(ApiClient(ApiPath.baseUrl));
          final createUserRepository = CreateUserRepositoryImpl(
            createUserApi,
            signUpApi,
          );
          return SignUpBloc(
            createUserUsecase: CreateUserUsecase(createUserRepository),
          );
        },
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is SignUpSuccess) {
              Navigator.push(context, Routes.createRoute(const HomeScreen()));
            } else if (state is SignUpEmailSuccess) {
              Navigator.push(context, Routes.createRoute(const HomeScreen()));
            }
          },
          builder: (context, state) {
            if (state is SignUpLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p20,
                    right: AppPadding.p20,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            AppAssets.companyLogo,
                            height: deviceDimension.height * 0.2,
                            width: deviceDimension.width * 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Style.getSemiBoldText(
                          "Sign Up",
                          FontSize.textSize25,
                          Colormanager.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Style.getCardViewWithBorder(
                          5,
                          Colormanager.indigoAccent.withOpacity(0.4),
                          1,
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.isEmail)
                                Style.getTextFormField(
                                  AppStrings.textEmail,
                                  "Enter Email Address",
                                  borderRadius: 10,
                                  showBorder: true,
                                  enabled: false,
                                  controller: emailController2,
                                  validator: _validateEmail,
                                  inputType: TextInputType.emailAddress,
                                  sufficIcon: const Icon(Icons.mail_outline),
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s'))
                                  ],
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              //Name
                              Style.getTextFormField(
                                "First Name",
                                "Enter First Name",
                                showBorder: true,
                                borderRadius: 10,
                                controller: nameController,
                                validator: _validateFirstName,
                                sufficIcon: const Icon(Icons.person_outline),
                                inputType: TextInputType.name,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]')),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //Last Name
                              Style.getTextFormField(
                                "Last Name",
                                "Enter Last Name",
                                showBorder: true,
                                borderRadius: 10,
                                controller: lastNameContoller,
                                validator: _validateLastName,
                                sufficIcon: const Icon(Icons.person_outline),
                                inputType: TextInputType.name,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]')),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (!widget.isEmail)
                                Style.getTextFormField(
                                  AppStrings.textEmail,
                                  "Enter Email Address",
                                  borderRadius: 10,
                                  showBorder: true,
                                  controller: emailController,
                                  validator: _validateEmail,
                                  inputType: TextInputType.emailAddress,
                                  sufficIcon: const Icon(Icons.mail_outline),
                                  inputAction: TextInputAction.done,
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s'))
                                  ],
                                ),

                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.isEmail == false)
                                Style.getTextFormField(
                                  AppStrings.textContact,
                                  AppStrings.textContactNumberHint,
                                  height: 80,
                                  enabled: false,
                                  controller: numberController,
                                  validator: _validateNumber,
                                  inputType: TextInputType.number,
                                  inputAction: TextInputAction.done,
                                  showBorder: true,
                                  borderRadius: 10,
                                  maxLength: 10,
                                  sufficIcon: const Icon(Icons.phone_outlined),
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    )
                                  ],
                                ),
                              if (widget.isEmail)
                                Style.getTextFormField(
                                  AppStrings.textContact,
                                  AppStrings.textContactNumberHint,
                                  height: 80,
                                  controller: numberController2,
                                  validator: _validateNumber,
                                  inputType: TextInputType.number,
                                  showBorder: true,
                                  borderRadius: 10,
                                  maxLength: 10,
                                  sufficIcon: const Icon(Icons.phone_outlined),
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    )
                                  ],
                                ),

                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.isEmail)
                                Style.getTextFormField(
                                  AppStrings.textPassword,
                                  AppStrings.textPasswordHint,
                                  obscureText: showPassword,
                                  validator: _validatePassword,
                                  borderRadius: 10,
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: deviceDimension.height * 0.05,
                        ),
                        Center(
                          child: Style.getTextButton(
                            deviceDimension.width,
                            50,
                            AppStrings.createAccount,
                            onClick: widget.isEmail
                                ? () {
                                    bool isValid = _submitForm();
                                    if (isValid) {
                                      context
                                          .read<SignUpBloc>()
                                          .add(SignUpCreateAccountButtonPressed(
                                            firstName: nameController.text,
                                            lastName: lastNameContoller.text,
                                            email: PreferenceManager.getEmail()
                                                .toString(),
                                            contactNo: numberController2.text,
                                            password: passwordController.text,
                                            otp:
                                                PreferenceManager.getOtpNumber()
                                                    .toString(),
                                          ));
                                    }
                                  }
                                : () {
                                    bool isValid = _submitForm();
                                    if (isValid) {
                                      context.read<SignUpBloc>().add(
                                            CreateAccountButtonPressed(
                                              firstName: nameController.text,
                                              lastName: lastNameContoller.text,
                                              email: emailController.text,
                                              contactNo: numberController.text,
                                              otp: PreferenceManager
                                                      .getOtpNumber()
                                                  .toString(),
                                            ),
                                          );
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
      ),
    );
  }
}

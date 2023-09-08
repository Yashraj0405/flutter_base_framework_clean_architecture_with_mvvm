
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/preference_manager.dart';
import '../../../data/data_sources/remote_data_sources/signup/createUser_api.dart';
import '../../../data/data_sources/remote_data_sources/signup/signup_api.dart';
import '../../../data/repositories/signup/createUser_repository_impl.dart';
import '../../../domain/usecases/signup/createUser_usecase.dart';
import '../../bloc/signup/signup_bloc.dart';
import '../../bloc/signup/signup_event.dart';
import '../../bloc/signup/signup_state.dart';
import '../../manager/constant/form_validation.dart';
import '../../manager/network/api_client.dart';
import '../../manager/network/api_path.dart';
import '../../manager/resources/color_manager.dart';
import '../../manager/resources/routes_manager.dart';
import '../../manager/resources/strings_manager.dart';
import '../../manager/style/style.dart';
import '../home/home_screen.dart';

class SignUpScreenT2 extends StatefulWidget {
  static const routeName = '/sinUpScreenT2';
  final bool isEmail;
  const SignUpScreenT2({
    super.key,
    required this.isEmail,
  });

  @override
  State<SignUpScreenT2> createState() => _SignUpScreenT2State();
}

class _SignUpScreenT2State extends State<SignUpScreenT2> {
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
                                "SignUp",
                                40,
                                Colormanager.white,
                              ),
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
                              //autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  if (widget.isEmail)
                                    Style.getTextFormField(
                                      AppStrings.textEmail,
                                      "Enter Email Address",
                                      borderRadius: 5,
                                      showBorder: true,
                                      enabled: false,
                                      controller: emailController2,
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
                                    height: 10,
                                  ),
                                  Style.getTextFormField(
                                    "First Name",
                                    "Enter First Name",
                                    showBorder: true,
                                    borderRadius: 10,
                                    controller: nameController,
                                    validator: _validateFirstName,
                                    sufficIcon:
                                        const Icon(Icons.person_outline),
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
                                    sufficIcon:
                                        const Icon(Icons.person_outline),
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
                                      sufficIcon:
                                          const Icon(Icons.mail_outline),
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
                                      sufficIcon:
                                          const Icon(Icons.phone_outlined),
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
                                      sufficIcon:
                                          const Icon(Icons.phone_outlined),
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
                                  SizedBox(
                                    height: widget.isEmail
                                        ? deviceDimension.height * 0.15
                                        : deviceDimension.height * 0.2,
                                  ),
                                  // Login button
                                  Center(
                                    child: Style.getTextButton(
                                      deviceDimension.width,
                                      50,
                                      AppStrings.createAccount,
                                      borderRadius: 10,
                                      onClick: widget.isEmail
                                          ? () {
                                              bool isValid = _submitForm();
                                              if (isValid) {
                                                context.read<SignUpBloc>().add(
                                                        SignUpCreateAccountButtonPressed(
                                                      firstName:
                                                          nameController.text,
                                                      lastName:
                                                          lastNameContoller
                                                              .text,
                                                      email: PreferenceManager
                                                              .getEmail()
                                                          .toString(),
                                                      contactNo:
                                                          numberController2
                                                              .text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      otp: PreferenceManager
                                                              .getOtpNumber()
                                                          .toString(),
                                                    ));
                                              }
                                            }
                                          : () {
                                              bool isValid = _submitForm();
                                              if (isValid) {
                                                context.read<SignUpBloc>().add(
                                                      CreateAccountButtonPressed(
                                                        firstName:
                                                            nameController.text,
                                                        lastName:
                                                            lastNameContoller
                                                                .text,
                                                        email: emailController
                                                            .text,
                                                        contactNo:
                                                            numberController
                                                                .text,
                                                        otp: PreferenceManager
                                                                .getOtpNumber()
                                                            .toString(),
                                                      ),
                                                    );
                                              }
                                            },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/preference_manager.dart';
import '../../../data/data_sources/remote_data_sources/login/otp_authentication_api.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../manager/constant/form_validation.dart';
import '../../manager/network/api_client.dart';
import '../../manager/network/api_path.dart';
import '../../manager/resources/color_manager.dart';
import '../../manager/resources/font_manager.dart';
import '../../manager/resources/routes_manager.dart';
import '../../manager/resources/strings_manager.dart';
import '../../manager/style/style.dart';
import '../home/home_screen.dart';

class OTPScreenT2 extends StatefulWidget {
  static const routeName = '/OTPScreenT2';
  const OTPScreenT2({super.key});

  @override
  State<OTPScreenT2> createState() => _OTPScreenT2State();
}

class _OTPScreenT2State extends State<OTPScreenT2> {
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

  //Duration of the countdown timer
  static const _timerDuration = 60;
  // Stream controller to manage the timer stream
  final StreamController _timerStream2 = StreamController<int>();
  int? timerCounter; // Track current timer value
  Timer? _resendCodeTimer; // Timer for countdown

  int _countDownValue = _timerDuration;

  @override
  void initState() {
    //activeCounter(); // Start the countdown timer
    _startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    // _timerStream2.close(); // Close the stream controller
    // _resendCodeTimer!.cancel(); // Cancel the countdown timer
    _startCountdown();
    super.dispose();
  }

  activeCounter() {
    // Start a periodic timer to update timer value
    _resendCodeTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        // Update the timer stream with remaining time
        if (_timerDuration - timer.tick > 0) {
          _timerStream2.sink.add(_timerDuration - timer.tick);
        } else {
          _timerStream2.sink.add(0); // Timer reached 0
          _resendCodeTimer!.cancel(); // Cancel the countdown timer
        }
      },
    );
  }

  void _startCountdown() {
    // Countdown logic using Future.delayed
    Future.delayed(const Duration(seconds: 1), () {
      if (_countDownValue > 0) {
        setState(() {
          _countDownValue--;
        });
        _startCountdown(); // Continue the countdown
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceDimension = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // Listener for changes in the LoginBloc state
          if (state is LoginFailure) {
            // If the state is LoginFailure, show a SnackBar with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is ValidateOtpSuccess) {
            // If the state is LoginFailure, show a SnackBar with the error message
            Navigator.push(context, Routes.createRoute(const HomeScreen()));
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
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
                              40,
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
                                  height: 30,
                                ),
                                Style.getMediumText(
                                  "Please Enter 4 digit Code sent to your registerd",
                                  FontSize.textSize16,
                                  Colormanager.black,
                                ),
                                // Display the user's contact number
                                Style.getMediumText(
                                  "mobile number +91${PreferenceManager.getContactNumber()!}",
                                  FontSize.textSize16,
                                  Colormanager.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
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
                                // Row for "Resend OTP" link and countdown timer
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text for "Resend OTP"
                                    Style.getSemiBoldText(
                                      AppStrings.resendOtpText,
                                      FontSize.textSize16,
                                      Colormanager.grey1,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        if (_countDownValue == 0) {
                                          // Resend OTP logic when timer reaches 0
                                          _getOtpLogin();

                                          // Reset the timer value and restart the countdown
                                          setState(() {
                                            _countDownValue = _timerDuration;
                                          });
                                          _startCountdown();
                                        }
                                      },
                                      child: Style.getSemiBoldText(
                                        _countDownValue == 0
                                            ? 'Resend'
                                            : '$_countDownValue Secs ',
                                        FontSize.textSize16,
                                        Colormanager.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: deviceDimension.height * 0.4,
                                ),
                                // Validate OTP button
                                Center(
                                  child: Style.getTextButton(
                                    deviceDimension.width,
                                    50,
                                    AppStrings.validateText,
                                    borderRadius: 10,
                                    onClick: () {
                                      // Trigger OTP validation through LoginBloc
                                      bool isValid = _submitForm();
                                      if (isValid) {
                                        context.read<LoginBloc>().add(
                                              ValidateButtonPressed(
                                                validateOtp: otpController.text,
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
    );
  }
}

// This function is used to initiate the process of sending an OTP to the user's contact number.
// It uses the OtpAuthenticationApi to send the OTP.
_getOtpLogin() async {
  // Retrieve the user's contact number from the preference manager
  var mobile = PreferenceManager.getContactNumber();

  // Create an instance of the OtpAuthenticationApi with the appropriate API client
  final optAuntenticationApi = OtpAuthenticationApi(ApiClient(ApiPath.baseUrl));

  // Use the otpAuthenticationApi to send the OTP to the user's contact number
  optAuntenticationApi.loginUserOtp(mobile!);
}

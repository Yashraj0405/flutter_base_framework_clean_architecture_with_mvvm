import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/app_assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
import '../../manager/resources/value_manager.dart';
import '../../manager/style/style.dart';
import '../../widgets/customAppBar.dart';
import '../home/home_screen.dart';

class OTPScreenT1 extends StatefulWidget {
  static const routeName = '/OtpScreenT1';
  const OTPScreenT1({super.key});

  @override
  State<OTPScreenT1> createState() => _OTPScreenT1State();
}

class _OTPScreenT1State extends State<OTPScreenT1> {
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
  final StreamController _timerStream = StreamController<int>();
  int? timerCounter; // Track current timer value
  Timer? _resendCodeTimer; // Timer for countdown
  int _countdownValue = _timerDuration;

  @override
  void initState() {
    // activeCounter(); // Start the countdown timer
    _startCountdown(); // Start the countdown
    super.initState();
  }

  @override
  void dispose() {
    // _timerStream.close(); // Close the stream controller
    // _resendCodeTimer!.cancel(); // Cancel the countdown timer
    _startCountdown(); // Start the countdown
    super.dispose();
  }

  activeCounter() {
    // Start a periodic timer to update timer value
    _resendCodeTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        // Update the timer stream with remaining time
        if (_timerDuration - timer.tick > 0) {
          _timerStream.sink.add(_timerDuration - timer.tick);
        } else {
          _timerStream.sink.add(0); // Timer reached 0
          _resendCodeTimer!.cancel(); // Cancel the countdown timer
        }
      },
    );
  }

  void _startCountdown() {
    // Countdown logic using Future.delayed
    Future.delayed(const Duration(seconds: 1), () {
      if (_countdownValue > 0) {
        setState(() {
          _countdownValue--;
        });
        _startCountdown(); // Continue the countdown
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceDimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar("", elevation: 0),
      backgroundColor: Colormanager.white,
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
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          AppAssets.t1Otp,
                          height: deviceDimension.height * 0.3,
                          width: deviceDimension.width * 0.9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      // Title for OTP screen
                      Style.getSemiBoldText(
                        //"Enter OTP",
                        "enterOTP".tr,
                        FontSize.textSize20,
                        Colormanager.black,
                      ),
                      // Subtitle for OTP screen
                      Style.getMediumText(
                          //"Please Enter 4 digit Code sent to your registerd mobile number",
                          "pleaseEnter4DigitCode ${PreferenceManager.getContactNumber()!}"
                              .tr,
                          FontSize.textSize16,
                          Colormanager.black,
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                          softWrap: true),
                      // Display the user's contact number
                      // Style.getMediumText(
                      //   "mobile number +91${PreferenceManager.getContactNumber()!}",
                      //   FontSize.textSize16,
                      //   Colormanager.black,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // OTP input field
                      // Style.getTextinputField(
                      //   AppStrings.textEnterOtp,
                      //   height: 60,
                      //   showBorder: true,
                      //   borderRadius: 5,
                      //   maxLength: 4,
                      //   controller: otpController,
                      //   inputAction: TextInputAction.done,
                      //   inputType: TextInputType.number,
                      // ),
                      Style.getTextFormField(
                        "OTP",
                        //AppStrings.textEnterOtp,
                        "enterOTP".tr,
                        height: 80,
                        controller: otpController,
                        validator: _validateOtp,
                        inputType: TextInputType.number,
                        showBorder: true,
                        borderRadius: 5,
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
                            //AppStrings.resendOtpText,
                            "resendCodeAfter".tr,
                            FontSize.textSize16,
                            Colormanager.grey1,
                          ),
                          const SizedBox(
                            width: 5,
                          ),

                          GestureDetector(
                            onTap: () {
                              if (_countdownValue == 0) {
                                // Resend OTP logic when timer reaches 0
                                _getOtpLogin();

                                // Reset the timer value and restart the countdown
                                setState(() {
                                  _countdownValue = _timerDuration;
                                });
                                _startCountdown();
                              }
                            },
                            child: Style.getSemiBoldText(
                              _countdownValue == 0
                                  ? 'resend'.tr
                                  : '$_countdownValue Secs ',
                              FontSize.textSize16,
                              Colormanager.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceDimension.height * 0.27,
                      ),
                      // Validate OTP button
                      Center(
                        child: Style.getTextButton(
                          deviceDimension.width,
                          50,
                          //AppStrings.validateText,
                          "validate".tr,
                          borderRadius: 5,
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

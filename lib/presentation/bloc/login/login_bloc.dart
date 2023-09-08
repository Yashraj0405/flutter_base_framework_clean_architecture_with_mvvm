import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/usecases/login/login_user_usecase.dart';

import '../../../domain/entities/login/user.dart';

// Define the LoginBloc class extending Bloc<LoginEvent, LoginState>
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase loginUserUsecase;

  // Constructor initializes the LoginBloc with an initial state
  LoginBloc({required this.loginUserUsecase}) : super(LoginInitial()) {
    // Defined event handlers using the 'on' method when the user presses the login button
    on<LoginButtonPressed>(
      (event, emit) async {
        emit(LoginLoading()); // Emit a loading state
        try {
          final user =
              await loginUserUsecase.login(event.email, event.password);
          emit(LoginSuccess(user: user)); // Emit a success state
        } catch (e) {
          print(e);
          emit(
            LoginFailure(error: "Failed To Login, Please Try Again"),
          ); // Emit a success state
        }
      },
    );

    // Defined event handlers using the 'on' method when the user presses the get otp button
    on<GetOTPButtonPressed>(
      (event, emit) async {
        emit(LoginLoading()); // Emit a loading state
        try {
          final otp = await loginUserUsecase.loginOtp(event.contactNumber);
          emit(OtpSuccess(otp: otp)); // Emit a success state
        } catch (e) {
          print(e);
          emit(
            LoginFailure(error: "Failed To Login using OTP, Please try again"),
          ); // Emit a success state
        }
      },
    );

    // Defined event handlers using the 'on' method when the user presses the validate button
    on<ValidateButtonPressed>(
      (event, emit) async {
        emit(LoginLoading()); // Emit a loading state
        try {
          final validate =
              await loginUserUsecase.validateOtp(event.validateOtp);
          emit(ValidateOtpSuccess(validate: validate)); // Emit a success state
        } catch (e) {
          print(e);
          emit(
            LoginFailure(error: "OTP Validation Failed, Please try again"),
          ); // Emit a success state
        }
      },
    );

  

    on<SubmitButtomPressed>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          final forgotPassword = await loginUserUsecase.forgotPassword(
            event.email,
            event.newPassword,
            event.confirmPassword,
          );
          emit(ForgotPasswordSuccess(forgotPassword: forgotPassword));
        } catch (e) {
          print(e);
          emit(
            LoginFailure(error: PreferenceManager.getMessage().toString()),
          );
        }
      },
    );

  
  }
}

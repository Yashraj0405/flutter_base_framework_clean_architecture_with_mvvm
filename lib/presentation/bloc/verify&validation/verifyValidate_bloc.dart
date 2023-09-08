import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/usecases/verify&validate/verify&validate_usecase.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/verify&validation/verifyValidate_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/verify&validation/verifyValidate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyValidateBloc
    extends Bloc<VerifyValidateEvent, VerifyValidateState> {
  final VerifyValidateUseCase verifyValidateUseCase;

  VerifyValidateBloc({required this.verifyValidateUseCase})
      : super(VerifyValidateInitial()) {
    on<VerifyEmailButtonPressed>(
      (event, emit) async {
        emit(VerifyValidateLoading());
        try {
          final verifyEmail =
              await verifyValidateUseCase.verifyEmail(event.verifyEmail);

          emit(VerifyEmailSuccess(verifyEmail: verifyEmail));
        } catch (e) {
          print(e);
          emit(
            VerifyValidateFailure(error: "Email Address does not exists"),
          ); // Emit a success state
        }
      },
    );

    on<VerifyContactButtonPressed>(
      (event, emit) async {
        emit(VerifyValidateLoading());
        try {
          final number =
              await verifyValidateUseCase.verifyContact(event.contactNumber);
          emit(VerifyContactSuccess(verifyContact: number));
        } catch (e) {
          emit(
            VerifyValidateFailure(
                error: "A registration with given mobile is already present."),
          );
        }
      },
    );

    on<ValidateOtpButtonPressed>(
      (event, emit) async {
        emit(VerifyValidateLoading());
        try {
          final validateOtp =
              await verifyValidateUseCase.validateOtp(event.validateOtp);
          emit(ValidateOtpSuccessState(validateOtp: validateOtp));
        } catch (e) {
          print(e);
          emit(
            VerifyValidateFailure(
                error: "Invalid OTP, Please enter correct OTP"),
          );
        }
      },
    );

    on<GenerateOtpButtonPressed>(
      (event, emit) async {
        emit(VerifyValidateLoading());
        try {
          final otp = await verifyValidateUseCase.generateOtp(event.email);
          emit(GenerateOtpSuccess(generateOtp: otp));
        } catch (e) {
          emit(
            VerifyValidateFailure(
                error:
                    "A registration with given Email address is already present."),
          );
        }
      },
    );
  }
}

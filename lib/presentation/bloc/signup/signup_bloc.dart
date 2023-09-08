import 'dart:math';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/usecases/signup/createUser_usecase.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/signup/signup_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CreateUserUsecase createUserUsecase;

  SignUpBloc({required this.createUserUsecase}) : super(SignUpInitial()) {
    on<CreateAccountButtonPressed>(
      (event, emit) async {
        emit(SignUpLoading());
        try {
          final createUser = await createUserUsecase.createUser(
            event.firstName,
            event.lastName,
            event.email,
            event.contactNo,
            event.otp,
          );
          emit(SignUpSuccess(createUser: createUser));
        } catch (e) {
          print(e);
          emit(
            SignUpFailure(error: "Failed To Create Account, Please Try Again"),
          );
        }
      },
    );

    on<SignUpCreateAccountButtonPressed>(
      (event, emit) async {
        emit(SignUpLoading());
        try {
          final signUp = await createUserUsecase.createUserUsingEmai(
            event.firstName,
            event.lastName,
            event.email,
            event.contactNo,
            event.password,
            event.otp,
          );
          emit(SignUpEmailSuccess(signUp: signUp));
        } catch (e) {
          print(e);
          emit(
            SignUpFailure(error: e.toString()),
          );
        }
        ;
      },
    );
  }
}

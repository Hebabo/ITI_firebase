import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseiti/data/model/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/signup_form_validator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepo _authRepo = AuthRepo();
  SignupBloc() : super(SignupInitialState()) {
    on<SignupInitialEvent>(_onSignupInitial);
    on<SignupLoadingEvent>((event, emit) => emit(SignupLoadingState()));
    on<SignupSuccessEvent>((event, emit) => emit(SignupSuccessState()));
    on<SignupFailureEvent>(
      (event, emit) => emit(SignupFailureState(error: event.error)),
    );
  }

  Future<void> _onSignupInitial(
    SignupInitialEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoadingState());

    final errors = SignUpValidator.validateSignUpFields(
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );

    if (event.username.isEmpty) {
      emit(SignupFailureState(error: "Username is required"));
    } else if (errors.isNotEmpty) {
      emit(SignupFailureState(error: errors.values.first));
    } else {
      try {
        final user = await _authRepo.signWithEmailAndPassword(
          email: event.email,
          password: event.password,
          name: event.username,
        );
        if (user != null && user.emailVerified) {
          emit(SignupSuccessState());
        } else if (user!.emailVerified) {
          emit(SignupFailureState(error: 'please verify your email address.'));
        } else {
          emit(
            SignupFailureState(error: 'email already used or wrong password.'),
          );
        }
      } on FirebaseAuthException catch (e) {
        debugPrint('faild to sign up with error >>> ${e.toString()}');
      }
    }
  }
}

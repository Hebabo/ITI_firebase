import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseiti/data/model/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/login_form_validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo = AuthRepo();
  LoginBloc() : super(LoginInitialState()) {
    on<LoginInitialEvent>(_onLoginInitial);
    on<LoginLogoutEvent>(_onLogout);
    on<LoginLoadingEvent>((event, emit) => emit(LoginLoadingState()));
    on<LoginSuccessEvent>((event, emit) => emit(LoginSuccessState()));
    on<LoginFailureEvent>(
      (event, emit) => emit(LoginFailureState(error: event.error)),
    );
  }

  Future<void> _onLoginInitial(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());

    final errors = LogInValidator.validateLogInFields(
      email: event.email,
      password: event.password,
    );

    if (errors.isNotEmpty) {
      emit(LoginFailureState(error: errors.values.first));
    } else {
      try {
        final user = await _authRepo.loginWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(error: 'invalid password or email.'));
        }
      } on FirebaseAuthException catch (e) {
        debugPrint('faild to sign up with error >>> ${e.toString()}');
      }
    }
  }

  Future<void> _onLogout(
    LoginLogoutEvent event,
    Emitter<LoginState> emit,
  ) async {
    await _authRepo.logout();
    emit(LogoutState());
  }
}

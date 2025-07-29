part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginInitialEvent extends LoginEvent {
  final String email;
  final String password;


  LoginInitialEvent({
    required this.email,
    required this.password,
  });
}

final class LoginLoadingEvent extends LoginEvent {}

final class LoginSuccessEvent extends LoginEvent {}

final class LoginFailureEvent extends LoginEvent {
  final String error;
  LoginFailureEvent({required this.error});
}

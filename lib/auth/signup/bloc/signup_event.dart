part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupInitialEvent extends SignupEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignupInitialEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

final class SignupLoadingEvent extends SignupEvent {}

final class SignupSuccessEvent extends SignupEvent {}

final class SignupFailureEvent extends SignupEvent {
  final String error;
  SignupFailureEvent({required this.error});
}

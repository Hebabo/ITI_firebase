import 'package:bloc/bloc.dart';
import 'package:firebaseiti/auth/login/bloc/login_bloc.dart';
import 'package:firebaseiti/data/model/auth_repo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepo _authRepo = AuthRepo();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLogoutEvent>(_onLogout);
  }

  Future<void> _onLogout(
    ProfileLogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await _authRepo.logout();
    emit(ProfileLogoutState());
  }
}

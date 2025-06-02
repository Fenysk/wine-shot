import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/auth_usecases.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthUsecases _authUsecase;

  ProfileBloc({required AuthUsecases authUsecase})
      : _authUsecase = authUsecase,
        super(ProfileInitial()) {
    on<UpdateProfile>(_updateProfile);
  }

  Future<void> _updateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    var result = await _authUsecase.updateProfile(event.firstName, event.lastName, event.email, event.phone);

    result.fold(
      (errorMessage) => emit(ProfileFailure(errorMessage: errorMessage.toString())),
      (_) => emit(ProfileUpdated()),
    );
  }
}

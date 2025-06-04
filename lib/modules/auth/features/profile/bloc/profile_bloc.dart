import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/update_profile_usecase.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileBloc({
    required UpdateProfileUseCase updateProfileUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _updateProfileUseCase = updateProfileUseCase,
        super(ProfileInitial()) {
    on<UpdateProfile>(_updateProfile);
  }

  Future<void> _updateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    var result = await _updateProfileUseCase(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
    );

    result.fold(
      (errorMessage) => emit(ProfileFailure(errorMessage: errorMessage.toString())),
      (_) => emit(ProfileUpdated()),
    );
  }
}

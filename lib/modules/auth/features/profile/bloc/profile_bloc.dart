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
    on<UpdateFirstName>(_updateFirstName);
  }

  Future<void> _updateFirstName(UpdateFirstName event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    var result = await _authUsecase.updateFirstName(event.firstName);

    result.fold(
      (errorMessage) => emit(ProfileFailure(message: errorMessage.toString())),
      (_) => emit(ProfileUpdated()),
    );
  }
}

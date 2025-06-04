import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterInitial()) {
    on<RegistrationRequested>(_registrationRequested);
  }

  void _registrationRequested(
    RegistrationRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    var result = await _registerUseCase(
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
      email: event.email,
      password: event.password,
      iAgree: event.iAgree,
    );

    emit(result.fold(
      (error) => RegisterFailure(error: error.getMessage()),
      (_) => RegisterSuccess(),
    ));
  }
}

part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateFirstName extends ProfileEvent {
  final String firstName;

  const UpdateFirstName({required this.firstName});
}

part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}

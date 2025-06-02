part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileUpdated extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure({required this.message});

  @override
  List<Object> get props => [
        message
      ];
}

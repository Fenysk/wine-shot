import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;

  final String firstName;

  final String lastName;

  final String phone;

  final String email;

  final bool isEmailVerified;

  final List<String> roles;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.isEmailVerified,
    required this.roles,
  });

  static const empty = UserEntity(
    id: '-',
    firstName: '-',
    lastName: '-',
    phone: '-',
    email: '-',
    isEmailVerified: false,
    roles: [],
  );

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        phone,
        email,
        isEmailVerified,
        roles
      ];
}

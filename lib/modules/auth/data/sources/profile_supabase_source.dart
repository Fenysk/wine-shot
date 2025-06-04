import 'package:clean_starter/_core/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileSupabaseSource {
  Future<User?> getCurrentUser();
  Future<User?> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phone,
  );
}

class ProfileSupabaseSourceImpl implements ProfileSupabaseSource {
  @override
  Future<User?> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    try {
      final result = await SupabaseConfig.client.auth.updateUser(
        UserAttributes(
          email: email,
          phone: phone,
          data: {
            'first_name': firstName,
            'last_name': lastName,
          },
        ),
      );

      return result.user;
    } catch (error) {
      if (error is AuthException) {
        print("Supabase Auth Exception: ${error.toString()}");
        rethrow;
      }

      print("Unknown error during profile update: ${error.toString()}");
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return SupabaseConfig.client.auth.currentUser;
  }
}

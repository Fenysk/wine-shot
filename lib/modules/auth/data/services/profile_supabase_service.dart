import 'package:clean_starter/_core/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileSupabaseService {
  Future<User?> getCurrentUser();
  Future<User?> updateFirstName(String firstName);
}

class ProfileSupabaseServiceImpl implements ProfileSupabaseService {
  @override
  Future<User?> updateFirstName(String firstName) async {
    final result = await SupabaseConfig.client.auth.updateUser(
      UserAttributes(
        data: {
          'first_name': firstName,
        },
      ),
    );

    return result.user;
  }

  @override
  Future<User?> getCurrentUser() async {
    return SupabaseConfig.client.auth.currentUser;
  }
}

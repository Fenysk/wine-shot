import 'package:clean_starter/_core/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthSupabaseSource {
  Future<AuthResponse?> signUpWithEmailAndPassword(String email, String password);
  Future<AuthResponse?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}

class AuthSupabaseSourceImpl implements AuthSupabaseSource {
  @override
  Future<AuthResponse?> signUpWithEmailAndPassword(String email, String password) async {
    final result = await SupabaseConfig.client.auth.signUp(
      email: email,
      password: password,
    );

    return result;
  }

  @override
  Future<AuthResponse?> signInWithEmailAndPassword(String email, String password) async {
    final result = await SupabaseConfig.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return result;
  }

  @override
  Future<User?> getCurrentUser() async {
    return SupabaseConfig.client.auth.currentUser;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

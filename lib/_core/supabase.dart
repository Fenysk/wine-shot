import 'package:supabase_flutter/supabase_flutter.dart';
import 'environment.dart';

class SupabaseConfig {
  static SupabaseClient? _client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: Environment.supabaseUrl,
      anonKey: Environment.supabaseAnonKey,
    );

    _client = Supabase.instance.client;
  }

  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase client not initialized');
    }

    return _client!;
  }
}

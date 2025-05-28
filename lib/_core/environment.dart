import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String supabaseUrl = dotenv.env['SUPABASE_URL']!;
  static final String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
}

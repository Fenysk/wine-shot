import 'package:clean_starter/_core/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import '_init_modules.dart';
import 'constants.dart';
import 'database.dart';
import 'di.dart';
import 'http_client.dart';
import 'initial_app_data.dart';
import 'layout/adaptive_layout/adaptive_destination.dart';
import 'network_info.dart';
import 'app_router.dart';

class Bootstrap {
  static Future<void> init() async {
    //* Initiate Core
    di.registerSingleton<List<RouteBase>>([], instanceName: Constants.mainRoutesDiKey);
    di.registerSingleton<List<AdaptiveDestination>>([], instanceName: Constants.navTabsDiKey);

    await dotenv.load(fileName: ".env");

    await HttpClient.init();
    await LocalDatabase.init();
    await SupabaseConfig.init();
    await InitialAppData.load();

    //* Register Network
    di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

    //* Registering Modules
    await AppModules.initBeforeRunApp();

    //* initialize all routes
    di.registerLazySingleton(() => AppRouter(routes: di.get(instanceName: Constants.mainRoutesDiKey)));
  }
}

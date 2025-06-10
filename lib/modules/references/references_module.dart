import 'package:clean_starter/_core/constants.dart';
import 'package:clean_starter/modules/references/references_routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GetIt di = GetIt.instance;

Future<void> registerReferencesModule() async {
  // BLoC

  // Use cases

  // Repository

  // Data Sources
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(referencesRoutes);
}

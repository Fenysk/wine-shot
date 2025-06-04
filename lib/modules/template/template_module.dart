import 'package:go_router/go_router.dart';

import '../../_core/constants.dart';
import '../../_core/di.dart';
import 'features/template/bloc/template_bloc.dart';
import 'template_routes.dart';

Future<void> registerTemplateModule() async {
  //* inject blocs
  di.registerLazySingleton(() => TemplateBloc());

  //* register routes
  di<List<RouteBase>>(instanceName: Constants.mainRoutesDiKey).addAll(templateRoutes());
}

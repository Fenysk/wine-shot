import 'package:go_router/go_router.dart';
import 'package:clean_starter/modules/references/pages/references_page.dart';

final referencesRoutes = [
  GoRoute(
    path: '/references',
    builder: (context, state) => const ReferencesPage(),
  ),
];

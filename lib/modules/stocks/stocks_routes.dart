import 'package:go_router/go_router.dart';
import 'package:clean_starter/modules/stocks/pages/stocks_page.dart';

final stocksRoutes = [
  GoRoute(
    path: '/stocks',
    builder: (context, state) => const StocksPage(),
  ),
];

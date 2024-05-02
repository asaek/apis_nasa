import 'package:go_router/go_router.dart';

import '../../presentation/pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomePage.routerName,
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

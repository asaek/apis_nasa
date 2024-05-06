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
    GoRoute(
      name: ApiUnageDayPage.routerName,
      path: '/ApiUnageDayPage',
      builder: (context, state) => const ApiUnageDayPage(),
    ),
    GoRoute(
      name: EpicImage.routerName,
      path: '/EpicImage',
      builder: (context, state) => const EpicImage(),
    ),
  ],
);

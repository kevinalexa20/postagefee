import 'package:go_router/go_router.dart';
import 'package:postagecheck/src/presentation/pages/home_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    )
  ],
);

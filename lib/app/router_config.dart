import 'package:firebase_chat/view/splash/splash_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: SplashView.routeName,
    builder: (context, state) => const SplashView(),
  )
]);

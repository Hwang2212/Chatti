import 'package:firebase_chat/view/views.dart';
import 'package:go_router/go_router.dart';

/// Add Routes Here
final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: SplashView.routeName,
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    name: LoginView.goName,
    path: LoginView.routeName,
    builder: (context, state) => const LoginView(),
  ),
]);

import 'package:firebase_chat/view/views.dart';
import 'package:go_router/go_router.dart';

/// Add Routes Here
final GoRouter router = GoRouter(routes: [
  GoRoute(
    name: SplashView.goName,
    path: SplashView.routeName,
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    name: OnboardingView.goName,
    path: OnboardingView.routeName,
    builder: (context, state) => const OnboardingView(),
  ),
  GoRoute(
    name: LoginView.goName,
    path: LoginView.routeName,
    builder: (context, state) => const LoginView(),
  ),
]);

import 'package:firebase_chat/view/chatroom/chatroom_view.dart';
import 'package:firebase_chat/view/home/home_view.dart';
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
  GoRoute(
    name: HomeView.goName,
    path: HomeView.routeName,
    builder: (context, state) => const HomeView(),
  ),
  GoRoute(
    name: ChatroomView.goName,
    path: ChatroomView.routeName,
    builder: (context, state) => ChatroomView(
      chatroomId: state.queryParams['chatroomId'],
    ),
  ),
]);

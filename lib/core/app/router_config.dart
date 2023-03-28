import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/services/firebase/firestore.dart';
import 'package:firebase_chat/services/shared_preferences_service.dart';
import 'package:firebase_chat/view/chatroom/chatroom_view.dart';
import 'package:firebase_chat/view/home/home_view.dart';
import 'package:firebase_chat/view/views.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
      routes: [
        GoRoute(
          name: ChatroomView.goName,
          path: ChatroomView.routeName,
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => ChatroomViewModel(
                sharedPreferencesService: locator<SharedPreferencesService>(),
                firestoreService: locator<FirestoreService>()),
            child: ChatroomView(
              chatroomId: state.queryParams['chatroomId'],
            ),
          ),
        ),
      ]),
]);

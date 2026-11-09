import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/authentication/authentication_state.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/register/register_page.dart';

@lazySingleton
class NavigationRouter {
  NavigationRouter();

  static const mustAuthenticatedRoute = ['/home'];

  late final router = GoRouter(
    initialLocation: '/login',

    redirect: (context, state) {
      final currentRoute = state.matchedLocation;
      final auth = inject<AuthenticationCubit>();

      final isAuthenticated = auth.state.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isUnauthenticated = auth.state.maybeWhen(
        unauthenticated: () => true,
        orElse: () => false,
      );

      final isProtectedRoute =
      mustAuthenticatedRoute.contains(currentRoute);

      if (isProtectedRoute && isUnauthenticated) {
        return '/login';
      }

      if (isAuthenticated &&
          (currentRoute == '/login' || currentRoute == '/register')) {
        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}

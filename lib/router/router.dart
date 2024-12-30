import 'package:flutter/material.dart';
import 'package:flutter_movies_app/routes/details_route/details_route.dart';
import 'package:flutter_movies_app/routes/home_route/home_route.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: HomeRoute.path,
      pageBuilder: (context, state) => buildDefaultTransition<void>(
        context: context,
        state: state,
        child: const HomeRoute(),
      ),
    ),
    GoRoute(
      path: "${MovieDetailsRoute.path}/:id",
      pageBuilder: (context, state) => buildDefaultTransition<void>(
        context: context,
        state: state,
        child:  MovieDetailsRoute(id: state.pathParameters['id']!,),
      ),
    ),
  ],
);

CustomTransitionPage<T> buildDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  int transitionDuration = 300,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    transitionDuration: Duration(milliseconds: transitionDuration),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

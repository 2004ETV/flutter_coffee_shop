import 'package:flutter/foundation.dart';
import 'package:flutter_coffee_shop/src/config/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: MenuRouteData().location,
    routes: $appRoutes,
  );

  return router;
}

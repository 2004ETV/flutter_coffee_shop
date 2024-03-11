import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/screens/menu/menu_screen.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

Page<T> _buildPageWithDefaultTransition<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return cupertino.CupertinoPage<T>(
    key: state.pageKey,
    child: child,
  );
}

@immutable
@TypedGoRoute<MenuRouteData>(
  path: '/menu',
  name: 'menu',
)
class MenuRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MenuScreen();
  }

  @override
  cupertino.Page<void> buildPage(
      cupertino.BuildContext context, GoRouterState state) {
    return _buildPageWithDefaultTransition(
      state: state,
      child: const MenuScreen(),
    );
  }
}

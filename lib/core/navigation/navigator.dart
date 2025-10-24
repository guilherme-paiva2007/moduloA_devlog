part of '../navigation.dart';

final class AppRouter {
  final List<AppRoute> routes;
  late final AppRoute initialRoute;

  final List<GoRoute> _goRoutes = [];
  late final GoRouter router;
  
  AppRouter(this.routes, { AppRoute? initialRoute }) {
    if (routes.isEmpty) {
      throw Exception("At least one route must be provided to the router");
    }
    this.initialRoute = initialRoute ?? _findInitialRoute(routes);
    _init();
  }

  void _init() {
    _mapRoutes(routes);
    router = GoRouter(
      initialLocation: initialRoute.path,
      routes: _goRoutes,
    );
  }

  AppRoute? _tryFindInitialRoute(List<AppRoute> routes) {
    for (var route in routes) {
      if (route.builder != null || route.redirect) {
        return route;
      }

      if (route.subroutes.isNotEmpty) {
        final subroute = _tryFindInitialRoute(route.subroutes);
        if (subroute != null && (subroute.builder != null || subroute.redirect)) {
          return subroute;
        }
      }
    }
    return null;
  }

  AppRoute _findInitialRoute(List<AppRoute> routes) {
    final route = _tryFindInitialRoute(routes);
    if (route != null) return route;
    throw Exception("No valid initial route found");
  }

  void _mapRoutes(List<AppRoute> routes, [ String prefix = "/" ]) {
    late AppRoute route;
    for (route in routes) {
      route.path = "$prefix${route.parts.join("/")}";
      if (route._hasRouter) {
        throw Exception("Route ${route.path} is already assigned to a router");
      }
      route._hasRouter = true;
      route.router = this;
      if (route.redirect) {
        _goRoutes.add(
          GoRoute(
            path: route.path,
            redirect: (context, state) => route._redirection!,
            name: route.name
          ),
        );
      } else if (route.builder != null) {
          _goRoutes.add(
          GoRoute(
            path: route.path,
            builder: route.builder,
          )
        );
      }
      if (route.subroutes.isNotEmpty) {
        _mapRoutes(route.subroutes, "${route.path}/");
      }
    }
  }
}

final class AppRoute {
  final List<String> parts;
  final List<AppRoute> subroutes;
  final Widget Function(BuildContext context, GoRouterState state)? builder;

  final String? name;
  final String? displayName;
  final IconData? icon;
  final bool showOnDrawer;

  late final String path;
  late final AppRouter router;
  bool _hasRouter = false;

  final bool redirect;
  final String? _redirection;

  AppRoute({
    required String parts,
    required Widget Function(BuildContext context, GoRouterState state) this.builder,
    this.subroutes = const [],
    this.name, this.displayName, this.icon, this.showOnDrawer = false
  }): parts = parts.split("/"), redirect = false, _redirection = null;

  AppRoute.dir({
    required String parts,
    required this.subroutes,
    this.name, this.displayName, this.icon, this.showOnDrawer = false
  }): builder = null, parts = parts.split("/"), redirect = false, _redirection = null {
    if (subroutes.isEmpty) {
      throw Exception("Directory routes must have at least one subroute");
    }
  }

  AppRoute.redirect({
    required String parts,
    required String target,
    this.name, this.displayName, this.icon, this.showOnDrawer = false
  }): builder = null, parts = parts.split("/"), redirect = true, subroutes = const [], _redirection = target;

  void go(BuildContext context, [Map<String, String> params = const {}]) {
    String path = this.path;
    for (var MapEntry(:key, :value) in params.entries) {
      path = path.replaceFirst(":$key", value);
    }
    context.go(path);
  }
}
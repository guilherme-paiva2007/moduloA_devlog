part of '../navigation.dart';


AppRouter createRouter(bool initWithSession) {
  late final AppRoute login;
  late final AppRoute panel;
  return AppRouter([
    login = AppRoute(
      parts: "entrar",
      builder: (context, state) => const Login(),
    ),
    panel = AppRoute(
      parts: "",
      builder: (context, state) => const Panel(),
    ),
    // AppRoute.dir(
    //   parts: "screens",
    //   subroutes: [
    //     // AppRoute(
    //     //   parts: "1",
    //     //   builder: (context, state) => const Screen1(),
    //     // ),
    //     // AppRoute(
    //     //   parts: "2",
    //     //   builder: (context, state) => const Screen2(),
    //     // ),
    //     // AppRoute(
    //     //   parts: ":str",
    //     //   builder: (context, state) => Screen3(state.pathParameters["str"]!),
    //     // )
    //   ]
    // )
  ], initialRoute: initWithSession ? panel : login);
}
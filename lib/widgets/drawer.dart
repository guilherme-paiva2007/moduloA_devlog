import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/core/constants/sizes.dart';
import 'package:modulo_a_devlog/core/navigation.dart';
import 'package:modulo_a_devlog/main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: AppPaddings.medium,
              child: Image.asset("assets/images/logo_1.png"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var route in router!.routes)
                      if (route.showOnDrawer) DrawerRouteButton(route)
                  ],
                )
              )
            ),
            Padding(
              padding: AppPaddings.medium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      const FaIcon(FontAwesomeIcons.user),
                      Text("Nome do usuário")
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      context.go("/entrar");
                    },
                    icon: const FaIcon(FontAwesomeIcons.rightFromBracket)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerRouteButton extends StatelessWidget {
  final AppRoute route;
  
  const DrawerRouteButton(this.route, {
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.tiny,
      child: ListTile(
        leading: route.icon == null ? null : FaIcon(route.icon),
        title: Text(route.displayName ?? route.name ?? "Rota sem nome"),
        onTap: () {
          context.go(route.path);
        },
      ),
    );
  }
}
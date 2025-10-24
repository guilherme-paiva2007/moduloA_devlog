import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/drawer.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.title,
    this.actions = const [],
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
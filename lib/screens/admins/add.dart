import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class AdminAdd extends StatefulWidget {
  const AdminAdd({super.key});

  @override
  State<AdminAdd> createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
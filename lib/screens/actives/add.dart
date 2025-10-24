import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActiveAdd extends StatefulWidget {
  const ActiveAdd({super.key});

  @override
  State<ActiveAdd> createState() => _ActiveAddState();
}

class _ActiveAddState extends State<ActiveAdd> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
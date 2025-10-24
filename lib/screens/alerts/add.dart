import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class AlertAdd extends StatefulWidget {
  const AlertAdd({super.key});

  @override
  State<AlertAdd> createState() => _AlertAddState();
}

class _AlertAddState extends State<AlertAdd> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
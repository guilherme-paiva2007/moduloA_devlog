import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ResponsibleAdd extends StatefulWidget {
  const ResponsibleAdd({super.key});

  @override
  State<ResponsibleAdd> createState() => _ResponsibleAddState();
}

class _ResponsibleAddState extends State<ResponsibleAdd> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ResponsiblesList extends StatefulWidget {
  const ResponsiblesList({super.key});

  @override
  State<ResponsiblesList> createState() => _ResponsiblesListState();
}

class _ResponsiblesListState extends State<ResponsiblesList> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
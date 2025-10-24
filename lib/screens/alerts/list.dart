import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class AlertsList extends StatefulWidget {
  const AlertsList({super.key});

  @override
  State<AlertsList> createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
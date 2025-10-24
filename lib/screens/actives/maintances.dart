import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActiveMaintancesList extends StatefulWidget {
  const ActiveMaintancesList({super.key});

  @override
  State<ActiveMaintancesList> createState() => _ActiveMaintancesListState();
}

class _ActiveMaintancesListState extends State<ActiveMaintancesList> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActiveMaintanceAdd extends StatefulWidget {
  const ActiveMaintanceAdd({super.key});

  @override
  State<ActiveMaintanceAdd> createState() => _ActiveMaintanceAddState();
}

class _ActiveMaintanceAddState extends State<ActiveMaintanceAdd> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
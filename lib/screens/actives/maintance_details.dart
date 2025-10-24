import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActiveMaintanceDetails extends StatefulWidget {
  const ActiveMaintanceDetails({super.key});

  @override
  State<ActiveMaintanceDetails> createState() => _ActiveMaintanceDetailsState();
}

class _ActiveMaintanceDetailsState extends State<ActiveMaintanceDetails> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
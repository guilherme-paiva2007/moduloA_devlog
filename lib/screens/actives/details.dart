import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActiveDetails extends StatefulWidget {
  const ActiveDetails({super.key});

  @override
  State<ActiveDetails> createState() => _ActiveDetailsState();
}

class _ActiveDetailsState extends State<ActiveDetails> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
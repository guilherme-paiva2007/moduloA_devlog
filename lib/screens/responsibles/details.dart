import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ResponsibleDetails extends StatefulWidget {
  const ResponsibleDetails({super.key});

  @override
  State<ResponsibleDetails> createState() => _ResponsibleDetailsState();
}

class _ResponsibleDetailsState extends State<ResponsibleDetails> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Detalhe de destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
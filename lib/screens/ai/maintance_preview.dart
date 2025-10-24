import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class AiMaintancePreview extends StatefulWidget {
  const AiMaintancePreview({super.key});

  @override
  State<AiMaintancePreview> createState() => _AiMaintancePreviewState();
}

class _AiMaintancePreviewState extends State<AiMaintancePreview> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
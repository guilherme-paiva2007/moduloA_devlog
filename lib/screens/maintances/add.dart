import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/features/maintance.dart';
import 'package:dart_tools/tools.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class MaintanceAddScreen extends StatefulWidget {
  final String activeId;
  const MaintanceAddScreen({super.key, required this.activeId});

  @override
  State<MaintanceAddScreen> createState() => _MaintanceAddScreenState();
}

class _MaintanceAddScreenState extends State<MaintanceAddScreen> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController professionalController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar Manutenção",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo título removido, usar apenas descrição
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: "Tipo"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              controller: professionalController,
              decoration: const InputDecoration(labelText: "Profissional"),
            ),
            TextField(
              controller: costController,
              decoration: const InputDecoration(labelText: "Custo"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            AppButton(
              onPressed: _onRegisterPressed,
              enabled: !loading,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterPressed() {
    if (loading) return;
    setState(() => loading = true);
    Maintance.service.register(
      activeId: int.tryParse(widget.activeId) ?? 0,
      description: descriptionController.text,
      professional: professionalController.text,
      cost: double.tryParse(costController.text) ?? 0.0,
      type: typeController.text,
    ).then((result) {
      setState(() => loading = false);
      if (result is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao registrar manutenção")),
        );
      } else {
        Navigator.of(context).pop(true);
      }
    });
}
}
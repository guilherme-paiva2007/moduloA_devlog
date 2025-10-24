import 'package:dart_tools/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/core/constants/sizes.dart';
import 'package:modulo_a_devlog/features/responsible.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';
import 'package:modulo_a_devlog/widgets/text_field.dart';
import 'package:flutter_tools/form_validator.dart';

class ResponsibleAdd extends StatefulWidget {
  const ResponsibleAdd({super.key});

  @override
  State<ResponsibleAdd> createState() => _ResponsibleAddState();
}

class _ResponsibleAddState extends State<ResponsibleAdd> {
  final nameController = InputEdittingController<String>("");
  final descriptionController = InputEdittingController<String>("");
  final sectorController = InputEdittingController<String>("");
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar responsável",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 800
              ),
              child: Card(
                child: Padding(
                  padding: AppPaddings.big,
                  child: Column(
                    spacing: 24,
                    children: [
                      Text("Adicionar destinatário"),
                      AppTextInput(
                        controller: nameController,
                        label: "Nome",
                      ),
                      AppTextInput(
                        controller: descriptionController,
                        label: "Descrição",
                      ),
                      AppTextInput(
                        controller: sectorController,
                        label: "Setor",
                      ),
                      AppButton(
                        onPressed: () {
                          Responsible.service.register(
                            name: nameController.value.trim(),
                            description: descriptionController.value.trim(),
                            sector: sectorController.value.trim()
                          ).then((v) => v is Success ? context.go("/responsaveis") : null);
                        },
                        child: const Text("Cadastrar")
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
import 'package:dart_tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:dart_tools/result.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/core/constants/sizes.dart';
import 'package:modulo_a_devlog/features/actives.dart';
import 'package:modulo_a_devlog/features/responsible.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';
// ...existing code...
import 'package:modulo_a_devlog/widgets/text_field.dart';
import 'package:modulo_a_devlog/widgets/number_field.dart';
import 'package:modulo_a_devlog/widgets/date_field.dart';
import 'package:flutter_tools/form_validator.dart';

class ActiveAdd extends StatefulWidget {
  const ActiveAdd({super.key});

  @override
  State<ActiveAdd> createState() => _ActiveAddState();
}

class _ActiveAddState extends State<ActiveAdd> {
  final nameController = InputEdittingController<String>("");
  final descriptionController = InputEdittingController<String>("");
  final categoryController = InputEdittingController<String>("");
  final valueController = InputEdittingController<String>("");
  final acquisitionDateController = InputEdittingController<String>("");
  final serialNumberController = InputEdittingController<String>("");
  Responsible? selectedResponsible;
  late Future<Result<List<Responsible>, Warning<WarningCode>>> responsiblesFuture;

  @override
  void initState() {
    responsiblesFuture = Responsible.service.list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar ativo",
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
                      Text("Adicionar ativo"),
                      AppTextInput(
                        controller: nameController,
                        label: "Nome",
                      ),
                      AppTextInput(
                        controller: descriptionController,
                        label: "Descrição",
                      ),
                      AppTextInput(
                        controller: categoryController,
                        label: "Categoria",
                      ),
                      AppNumberInput(
                        controller: valueController,
                        label: "Valor",
                      ),
                      AppDateInput(
                        controller: acquisitionDateController,
                        label: "Data de aquisição",
                      ),
                      AppNumberInput(
                        controller: serialNumberController,
                        label: "Número de série",
                      ),
                      FutureBuilder(
                        future: responsiblesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError || snapshot.data is Failure) {
                            return Text("Erro ao carregar responsáveis");
                          }
                          final responsibles = (snapshot.data as Success<List<Responsible>, Warning>).result;
                          return DropdownButton<Responsible>(
                            value: selectedResponsible,
                            hint: Text("Selecione o responsável"),
                            items: responsibles.map((r) => DropdownMenuItem(
                              value: r,
                              child: Text(r.name),
                            )).toList(),
                            onChanged: (r) {
                              setState(() {
                                selectedResponsible = r;
                              });
                            },
                          );
                        },
                      ),
                      AppButton(
                        onPressed: () {
                          if (selectedResponsible == null) return;
                          Active.service.register(
                            name: nameController.value.trim(),
                            description: descriptionController.value.trim().isEmpty ? null : descriptionController.value.trim(),
                            category: categoryController.value.trim(),
                            value: double.tryParse(valueController.value.trim()) ?? 0,
                            acquisitionDate: DateTime.parse(acquisitionDateController.value.trim()),
                            serialNumber: int.tryParse(serialNumberController.value.trim()) ?? 0,
                            responsible: selectedResponsible!
                          ).then((v) => v is Success ? context.go("/ativos") : null);
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
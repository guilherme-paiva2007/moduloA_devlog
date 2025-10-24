import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/features/maintance.dart';
import 'package:dart_tools/tools.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class MaintanceListScreen extends StatefulWidget {
  final int activeId;
  const MaintanceListScreen({super.key, required this.activeId});

  @override
  State<MaintanceListScreen> createState() => _MaintanceListScreenState();
}

class _MaintanceListScreenState extends State<MaintanceListScreen> {
  late Future<Result<List<Maintance>, Warning<WarningCode>>> maintances;

  @override
  void initState() {
    maintances = Maintance.service.listByActive(widget.activeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Manutenções do Ativo",
      body: FutureBuilder(
        future: maintances,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }
          final result = snapshot.data;
          if (result is Failure<List<Maintance>, Warning<WarningCode>>) {
            return Center(child: Text("Erro: ${result.failure.code.explanation}"));
          }
          final maintances = (result as Success<List<Maintance>, Warning<WarningCode>>).result;
          if (maintances.isEmpty) {
            return const Center(child: Text("Nenhuma manutenção encontrada."));
          }
          return ListView.builder(
            itemCount: maintances.length,
            itemBuilder: (context, index) {
              final m = maintances[index];
              return ListTile(
                title: Text(m.description),
                subtitle: Text("Tipo: ${m.type}\nProfissional: ${m.professional}"),
                trailing: Text("R\$ ${m.cost.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
    );
  }
}

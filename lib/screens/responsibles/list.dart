import 'package:dart_tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/features/responsible.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ResponsiblesList extends StatefulWidget {
  const ResponsiblesList({super.key});

  @override
  State<ResponsiblesList> createState() => _ResponsiblesListState();
}

class _ResponsiblesListState extends State<ResponsiblesList> {
  late final Future<Result<List<Responsible>, Warning>> responsibles;
  
  @override
  void initState() {
    responsibles = Responsible.service.list();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Destinatários",
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: AppButton(onPressed: () {
                context.go("/responsaveis/adicionar");
              }, child: const Text("Adicionar")),
            ),
          ),
          Expanded(
            flex: 3,
            child: FutureBuilder(
              future: responsibles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar responsáveis: ${snapshot.error}"),
                  );
                }

                final result = snapshot.data;
                if (result is Failure<List<Responsible>, Warning>) {
                  return Center(
                    child: Text("Erro ao carregar responsáveis: ${result.failure.code.explanation}"),
                  );
                }

                final responsibles = (result as Success<List<Responsible>, Warning>).result;

                return ListView.builder(
                  itemCount: responsibles.length,
                  itemBuilder: (context, index) {
                    final responsible = responsibles[index];
                    return ListTile(
                      title: Text(responsible.name),
                      subtitle: Text(responsible.description ?? ""),
                    );
                  },
                );
              },
            )
          )
        ],
      )
    );
  }
}
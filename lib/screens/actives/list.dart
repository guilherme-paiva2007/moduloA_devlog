import 'package:dart_tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/features/actives.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActivesList extends StatefulWidget {
  const ActivesList({super.key});

  @override
  State<ActivesList> createState() => _ActivesListState();
}

class _ActivesListState extends State<ActivesList> {
  late Future<Result<List<Active>, Warning>> actives;

  @override
  void initState() {
    actives = Active.service.list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Ativos",
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: AppButton(onPressed: () {
                context.go("/ativos/adicionar");
              }, child: const Text("Adicionar")),
            ),
          ),
          Expanded(
            flex: 3,
            child: FutureBuilder(
              future: actives,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar ativos: ${snapshot.error}"),
                  );
                }

                final result = snapshot.data;
                if (result is Failure<List<Active>, Warning>) {
                  return Center(
                    child: Text("Erro ao carregar ativos: ${result.failure.code.explanation}"),
                  );
                }

                final actives = (result as Success<List<Active>, Warning>).result;

                return ListView.builder(
                  itemCount: actives.length,
                  itemBuilder: (context, index) {
                    final active = actives[index];
                    return ListTile(
                      title: Text(active.name),
                      subtitle: Text(active.description ?? ""),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(active.category),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await Active.service.remove(active.$id);
                              setState(() {
                                this.actives = Active.service.list();
                              });
                            },
                          ),
                           IconButton(
                             icon: const Icon(Icons.add_circle, color: Colors.blue),
                             tooltip: "Adicionar manutenção",
                             onPressed: () {
                               context.push("/ativos/${active.$id}/maintances/adicionar", extra: active);
                             },
                           ),
                           IconButton(
                             icon: const Icon(Icons.list, color: Colors.green),
                             tooltip: "Listar manutenções",
                             onPressed: () {
                               context.push("/ativos/${active.$id}/maintances/listar", extra: active);
                             },
                           ),
                        ],
                      ),
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
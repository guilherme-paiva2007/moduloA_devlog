// ...existing code...

import 'package:flutter/material.dart';
import 'package:dart_tools/tools.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo_a_devlog/features/admin.dart';
import 'package:modulo_a_devlog/widgets/button.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class AdminsList extends StatefulWidget {
  const AdminsList({super.key});

  @override
  State<AdminsList> createState() => _AdminsListState();
}

class _AdminsListState extends State<AdminsList> {
  late final Future<Result<List<Admin>, Warning>> admins;

  @override
  void initState() {
    admins = Admin.service.list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Admins",
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: AppButton(onPressed: () {
                context.go("/admins/adicionar");
              }, child: const Text("Adicionar")),
            ),
          ),
          Expanded(
            flex: 3,
            child: FutureBuilder(
              future: admins,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar admins: ${snapshot.error}"),
                  );
                }

                final result = snapshot.data;
                if (result is Failure<List<Admin>, Warning>) {
                  return Center(
                    child: Text("Erro ao carregar admins: ${result.failure.code.explanation}"),
                  );
                }

                final admins = (result as Success<List<Admin>, Warning>).result;

                return ListView.builder(
                  itemCount: admins.length,
                  itemBuilder: (context, index) {
                    final admin = admins[index];
                    return ListTile(
                      title: Text(admin.name),
                      subtitle: Text(admin.email),
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
import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/widgets/scaffold.dart';

class ActivesList extends StatefulWidget {
  const ActivesList({super.key});

  @override
  State<ActivesList> createState() => _ActivesListState();
}

class _ActivesListState extends State<ActivesList> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Adicionar destinatário",
      body: Center(child: Text("a"),)
    );
  }
}
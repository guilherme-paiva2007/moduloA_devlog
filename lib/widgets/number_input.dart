import 'package:flutter/material.dart';

class AppNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool enabled;
  final int? maxLines;

  const AppNumberInput({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.enabled = true,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        enabled: enabled,
      ),
      keyboardType: TextInputType.number,
      maxLines: maxLines,
    );
  }
}

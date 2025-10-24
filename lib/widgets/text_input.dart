import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool enabled;
  final int? maxLines;

  const AppTextInput({
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
      maxLines: maxLines,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tools/form_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants/colors.dart';
import '../core/constants/sizes.dart';
import '../core/constants/styles.dart';

class AppDateInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final TextStyle? textStyle;
  final IconData? leading;
  final bool disabled;
  final InputEdittingController<String>? controller;
  final BorderSide? border;

  const AppDateInput({
    super.key,
    this.textStyle,
    this.label,
    this.leading,
    this.placeholder,
    this.controller,
    this.disabled = false,
    this.border,
  });

  Future<void> _selectDate(BuildContext context) async {
    final initialDate = DateTime.tryParse(controller?.value ?? "") ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && controller != null) {
      controller!.value = picked.toIso8601String().split('T').first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : () => _selectDate(context),
      child: AbsorbPointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: textStyle,
              controller: TextEditingController(text: controller?.value ?? ""),
              validator: (value) {
                return controller?.rule?.firstError(value ?? "");
              },
              textAlignVertical: TextAlignVertical.center,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: textStyle?.color,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: AppStyles.label.copyWith(
                  color: textStyle?.color
                ),
                hintText: placeholder ?? 'YYYY-MM-DD',
                hintStyle: const TextStyle(
                  fontSize: 0,
                  height: 0
                ),
                enabled: !disabled,
                border: OutlineInputBorder(borderSide: border ?? AppBorders.underline),
                enabledBorder: OutlineInputBorder(borderSide: border ?? AppBorders.underline),
                focusedBorder: OutlineInputBorder(borderSide: border ?? AppBorders.underline),
                errorBorder: OutlineInputBorder(borderSide: border ?? AppBorders.underlineRed),
                focusedErrorBorder: OutlineInputBorder(borderSide: border ?? AppBorders.underlineRed),
                contentPadding: AppPaddings.small,
                isDense: true,
                helperText: "",
                visualDensity: VisualDensity.compact,
                prefixIconColor: textStyle?.color ?? AppColors.base,
                prefixIcon: leading == null ? null : SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(child: FaIcon(leading,))
                ),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

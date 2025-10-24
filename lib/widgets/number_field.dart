import 'package:flutter/material.dart';
import 'package:flutter_tools/form_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants/colors.dart';
import '../core/constants/sizes.dart';
import '../core/constants/styles.dart';

class AppNumberInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final TextStyle? textStyle;
  final IconData? leading;
  final int maxLines;
  final bool disabled;
  final InputEdittingController<String>? controller;
  final BorderSide? border;

  const AppNumberInput({
    super.key,
    this.textStyle,
    this.label,
    this.leading,
    this.placeholder,
    this.controller,
    this.maxLines = 1,
    this.disabled = false,
    this.border,
  });

  Widget _input(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: textStyle,
          onChanged: (value) {
            controller?.value = value;
          },
          maxLines: maxLines,
          keyboardType: TextInputType.number,
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
            hintText: label,
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
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _input(context);
  }
}

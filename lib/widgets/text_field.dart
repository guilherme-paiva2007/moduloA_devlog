import 'package:flutter/material.dart';
import 'package:flutter_tools/form_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants/colors.dart';
import '../core/constants/sizes.dart';
import '../core/constants/styles.dart';

class AppTextInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final TextStyle? textStyle;
  final IconData? leading;
  final int maxLines;
  final InputSecretController? secret;
  final bool disabled;
  final InputEdittingController<String>? controller;
  final BorderSide? border;

  const AppTextInput({
    super.key,
    this.textStyle,
    this.label,
    this.leading,
    this.placeholder,
    this.controller,
    this.maxLines = 1,
    this.secret,
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
          autocorrect: secret == null ? true : !secret!.value,
          obscureText: secret == null ? false : secret!.value,
          validator: (value) {
            return controller?.rule?.firstError(value ?? "");
          },
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            suffixIconColor: textStyle?.color ?? AppColors.base,
            suffixIcon: secret == null ? null : Semantics(
              checked: !secret!.value,
              label: "Mostrar o conteúdo",
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  secret!.value = !secret!.value;
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: secret!.value
                      ? const FaIcon(FontAwesomeIcons.solidEyeSlash, size: 16,)
                      : const FaIcon(FontAwesomeIcons.solidEye, size: 16,),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return secret == null
      ? _input(context)
      : ValueListenableBuilder(
        valueListenable: secret!,
        builder: (context, value, child) => _input(context),
      );
  }
}

final class InputSecretController extends ValueNotifier<bool> {
  InputSecretController([super._value = true]);
}
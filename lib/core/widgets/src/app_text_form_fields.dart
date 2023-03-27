import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputAction? textInputAction;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final bool isNumber;
  final String? initialValue;
  const AppTextFormField(
      {Key? key,
      required this.textEditingController,
      this.isNumber = false,
      this.onChanged,
      this.textInputAction,
      this.validator,
      this.labelText,
      this.onTap,
      this.prefixIcon,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextFormField(
      // initialValue: initialValue ?? "",

      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      style:
          textTheme.bodyMedium?.copyWith(color: colorScheme.primaryContainer),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
      controller: textEditingController,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
    );
  }
}

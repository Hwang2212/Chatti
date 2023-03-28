import 'package:firebase_chat/core/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

class AddMessageField extends StatefulWidget {
  final TextEditingController addMessageTEC;
  final VoidCallback onTapButton;
  const AddMessageField(
      {super.key, required this.addMessageTEC, required this.onTapButton});

  @override
  State<AddMessageField> createState() => _AddMessageFieldState();
}

class _AddMessageFieldState extends State<AddMessageField> {
  TextEditingController get addMessageTEC => widget.addMessageTEC;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextFormField(
            textEditingController: addMessageTEC,
          ),
        ),
        AppIconButton(
            icon: const Icon(Icons.send), onPressed: widget.onTapButton)
      ],
    );
  }
}

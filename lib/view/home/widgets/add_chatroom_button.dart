import 'package:firebase_chat/core/widgets/global_widgets.dart';
import 'package:firebase_chat/view/chatlist/chatlist_view.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddChatroomButton extends StatelessWidget {
  const AddChatroomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton.text(
      backgroundColor: AppColors.darkBlue,
      // icon: const Icon(Icons.message),
      onPressed: () {
        context.goNamed(ChatListView.goName);
      },
      text: "Message",
    );
  }
}

import 'package:firebase_chat/core/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class ChatRoomTileArgs {
  final String username;
  final String? lastMessage;
  final String? imageUrl;
  final String? timeUpdated;
  final VoidCallback? onTap;

  ChatRoomTileArgs(
      {this.onTap,
      this.imageUrl,
      required this.username,
      this.lastMessage,
      this.timeUpdated});
}

class ChatRoomTile extends StatelessWidget {
  final ChatRoomTileArgs chatRoomTileArgs;
  const ChatRoomTile({super.key, required this.chatRoomTileArgs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: chatRoomTileArgs.onTap ?? () {},
      child: Card(
        color: AppColors.white.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p15, horizontal: AppPadding.p10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: chatRoomTileArgs.imageUrl == null
                    ? const Icon(Icons.people)
                    : ClipOval(
                        child: AppImageWidget(
                            isProfile: true,
                            imageUrl: chatRoomTileArgs.imageUrl),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoomTileArgs.username,
                      style: getExtraBoldStyle(fontSize: FontSize.s22),
                    ),
                    Text(
                      chatRoomTileArgs.lastMessage ?? " - ",
                      style: const TextStyle(
                          fontSize: FontSize.s12, color: AppColors.greYer),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p60),
                  child: Text(
                    chatRoomTileArgs.timeUpdated!.split("(")[0],
                    style: const TextStyle(
                        fontSize: FontSize.s12, color: AppColors.greYer),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/main.dart';
import 'package:firebase_chat/services/shared_preferences_service.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/chatroom/widgets/add_message_field.dart';
import 'package:firebase_chat/view/home/widgets/chatroom_tiles.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/core/widgets/global_widgets.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/utils/utils.dart';

class ChatroomView extends StatefulWidget {
  static const goName = 'chatroom-view';
  static const routeName = 'chatroom-view';
  final String? chatroomId;
  final String? messageTo;

  const ChatroomView({super.key, this.chatroomId, this.messageTo});

  @override
  State<ChatroomView> createState() => _ChatroomViewState();
}

class _ChatroomViewState extends State<ChatroomView> {
  final TextEditingController _messageTEC = TextEditingController();
  @override
  void initState() {
    if (widget.chatroomId != null) {
      context.read<ChatroomViewModel>().getChats(widget.chatroomId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatroomViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: mainAppBar(),
          body: Stack(children: [
            const BackgroundWidget(),
            buildMainContent(viewModel),
          ]),
          bottomNavigationBar: AddMessageField(
            addMessageTEC: _messageTEC,
            onTapButton: () async {
              String? fromUser =
                  locator<SharedPreferencesService>().getUserUid();
              String toUser = widget.chatroomId!
                  .split("_")
                  .firstWhere((element) => element != fromUser)
                  .toString();
              log(toUser.toString());
              viewModel.addMessage(
                  message: _messageTEC.text, sendBy: fromUser!, sendTo: toUser);
            },
          ),
        );
      },
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      title: Text(widget.messageTo ?? ""),
      leading: const AppBackButton(),
    );
  }

  Widget buildMainContent(ChatroomViewModel viewModel) {
    return SingleChildScrollView(child: buildChatList(viewModel));
  }

  Widget buildChatList(ChatroomViewModel viewModel) {
    return StreamBuilder(
        stream: viewModel.chatroomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SizedBox(
                  width: double.infinity,
                  height: ScreenUtils.idealScreenHeight,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: AppPadding.contentPadding,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;

                        // if (data['users'].first == viewModel.username) {
                        //   name = data['users'].last;
                        // } else {
                        //   name = data['users'].first;
                        // }
                        // log(data.toString());

                        return MessageTile(messageData: data);
                      })),
                )
              : Container();
        });
  }
}

class MessageTile extends StatelessWidget {
  final Map<String, dynamic> messageData;
  // final bool senderIsMe;
  const MessageTile({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    bool senderIsMe;
    if (messageData['from_user'] ==
        locator<SharedPreferencesService>().getUserUid()) {
      senderIsMe = true;
    } else {
      senderIsMe = false;
    }
    return Container(
      padding: EdgeInsets.only(
          bottom: 8, left: senderIsMe ? 0 : 24, right: senderIsMe ? 24 : 0),
      alignment: senderIsMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: senderIsMe ? AppColors.white : AppColors.aquaBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s20)),
        child: Container(
            margin: senderIsMe
                ? const EdgeInsets.only(left: 20)
                : const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Text(
              messageData['message'],
              textAlign: senderIsMe ? TextAlign.end : TextAlign.start,
            )),
      ),
    );
  }
}

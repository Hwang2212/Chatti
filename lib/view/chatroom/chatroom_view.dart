import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
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

  const ChatroomView({super.key, this.chatroomId});

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
            Positioned.fill(
                top: AppPadding.p20, child: buildMainContent(viewModel)),
          ]),
          bottomNavigationBar: AddMessageField(
            addMessageTEC: _messageTEC,
            onTapButton: () {
              viewModel.addMessage(
                  message: _messageTEC.text,
                  sendBy: "Andy Hwang",
                  sendTo: "Lala");
            },
          ),
        );
      },
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      title: const Text("Chatti!"),
      leading: const AppBackButton(),
    );
  }

  Widget buildMainContent(ChatroomViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildChatList(viewModel)
        // const SizedBox(
        //   height: AppSize.s20,
        // ),
      ],
    );
  }

  Widget buildChatList(ChatroomViewModel viewModel) {
    return StreamBuilder(
        stream: viewModel.chatroomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SizedBox(
                  width: double.infinity,
                  // height: ScreenUtils.idealScreenHeight,
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
                        
                        return Center(child: Text(data['from_user']));
                      })),
                )
              : Container();
        });
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool senderIsMe;
  const MessageTile({super.key, required this.message, required this.senderIsMe});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

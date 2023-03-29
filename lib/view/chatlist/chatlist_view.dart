import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/locator.dart';
import 'package:firebase_chat/main.dart';
import 'package:firebase_chat/services/shared_preferences_service.dart';
import 'package:firebase_chat/core/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/chatroom/chatroom_view.dart';
import 'package:firebase_chat/view/home/widgets/chatroom_tiles.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/core/widgets/global_widgets.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/src/chatlist_viewmodel.dart';

class ChatListView extends StatefulWidget {
  static const goName = 'chatlist-view';
  static const routeName = 'chatlist-view';

  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  void initState() {
    context.read<ChatListViewModel>().getChatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatListViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: mainAppBar(),
          body: Stack(children: [
            const BackgroundWidget(),
            Positioned.fill(
                top: AppPadding.p20, child: buildMainContent(viewModel)),
          ]),
          // floatingActionButton: AddC,
        );
      },
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      title: const Text("Users"),
      leading: const AppBackButton(),
    );
  }

  Widget buildMainContent(ChatListViewModel viewModel) {
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

  Widget buildChatList(ChatListViewModel viewModel) {
    return StreamBuilder(
        stream: viewModel.chatlistStream,
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

                        return ChatRoomTile(
                          chatRoomTileArgs: ChatRoomTileArgs(
                              username: data['username'],
                              onTap: () {
                                String newChatroomId =
                                    "${data['id']}_${locator<SharedPreferencesService>().getUserUid()}";

                                log(newChatroomId);
                                context.goNamed(ChatroomView.goName,
                                    queryParams: {'chatroomId': newChatroomId});
                              },
                              lastMessage: "",
                              imageUrl: data['photoUrl'],
                              timeUpdated: ""),
                        );
                      })),
                )
              : const SizedBox.shrink();
        });
  }
}

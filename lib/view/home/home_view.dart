import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/main.dart';
import 'package:firebase_chat/services/shared_preferences_service.dart';
import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/home/widgets/chatroom_tiles.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/view/widgets/global_widgets.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const goName = 'home-view';
  static const routeName = '/home-view';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  @override
  void initState() {
    context.read<HomeViewModel>().getChatroomList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: mainAppBar(),
          body: Stack(children: [
            const BackgroundWidget(),
            Positioned.fill(
                top: AppPadding.p20, child: buildMainContent(viewModel)),
          ]),
        );
      },
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      title: const Text("Chatti!"),
    );
  }

  Widget buildMainContent(HomeViewModel viewModel) {
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

  Widget buildChatList(HomeViewModel viewModel) {
    return StreamBuilder(
        stream: viewModel.chatroomStream,
        builder: (context, snapshot) {
          log("DATA ${snapshot.data!.docs.length}");
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

                        String name;
                        if (data['users'].first == viewModel.username) {
                          name = data['users'].last;
                        } else {
                          name = data['users'].first;
                        }
                        return ChatRoomTile(
                          chatRoomTileArgs: ChatRoomTileArgs(
                              username: name,
                              lastMessage: data['last_message'],
                              timeUpdated: data['timeUpdated'].toString()),
                        );
                      })),
                )
              : const Center(
                  child: Text("No Chats"),
                );
        });
  }
}

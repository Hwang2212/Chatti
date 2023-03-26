import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_chat/generated/locale_keys.g.dart';
import 'package:firebase_chat/main.dart';
import 'package:firebase_chat/utils/utils.dart';
import 'package:firebase_chat/view/base_view.dart';
import 'package:firebase_chat/view/themes/themes.dart';
import 'package:firebase_chat/view/widgets/global_widgets.dart';
import 'package:firebase_chat/viewmodel/view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        buildChatList()
        // const SizedBox(
        //   height: AppSize.s20,
        // ),
      ],
    );
  }

  Widget buildChatList() {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtils.idealScreenHeight,
      child: ListView.builder(
          shrinkWrap: true,
          padding: AppPadding.contentPadding,
          itemCount: 20,
          itemBuilder: ((context, index) {
            return Card(
              color: AppColors.white.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p15, horizontal: AppPadding.p10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.people),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User $index",
                            style: getExtraBoldStyle(fontSize: FontSize.s22),
                          ),
                          const Text(
                            "Messages here",
                            style: TextStyle(
                                fontSize: FontSize.s12,
                                color: AppColors.greYer),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: AppPadding.p60),
                        child: Text(
                          "20/12/23",
                          style: TextStyle(
                              fontSize: FontSize.s12, color: AppColors.greYer),
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }
}

class HomeScreenChatsModel {
  final String userName;
  final String lastMessage;
  final DateTime timeUpdated;

  HomeScreenChatsModel(this.userName, this.lastMessage, this.timeUpdated);
}

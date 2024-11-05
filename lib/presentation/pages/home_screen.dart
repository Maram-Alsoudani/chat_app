import 'package:chat_app/core/reusable_components/base_screen_layout.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/presentation/manager/providers/home_screen_view_model.dart';
import 'package:chat_app/presentation/widgets/room_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/font_constants.dart';
import '../../di/di.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: BaseScreenLayout(
          scaffold: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppStrings.home,
            style: getTextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                fontFamily: FontConstants.poppins,
                color: ColorManager.white),
          ),
        ),
        body: StreamBuilder(
            stream: viewModel.getRooms(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Center(child: Text('Error'));
              } else if (asyncSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                final roomsList = asyncSnapshot.data ?? [];

                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: roomsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.chatScreen,
                                arguments: roomsList[index]?.title);
                          },
                          child: RoomWidget(room: roomsList[index]));
                    });
              }
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManager.primaryColor,
            child: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.createNewRouteScreen);
            }),
      )),
    );
  }
}

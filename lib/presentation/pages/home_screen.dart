import 'package:chat_app/core/reusable_components/base_screen_layout.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/font_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
        scaffold: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: getTextStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.bold,
              fontFamily: FontConstants.poppins,
              color: ColorManager.white),
        ),
      ),
      body: Center(
        child: Text('Home Screen Content'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.primaryColor,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {}),
    ));
  }
}

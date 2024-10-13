import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';
import '../utils/images.dart';

class BaseScreenLayout extends StatelessWidget {
  Widget scaffold;

  BaseScreenLayout({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ColorManager.white,
        ),
        Image.asset(
          AppImages.background,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        scaffold
      ],
    );
  }
}

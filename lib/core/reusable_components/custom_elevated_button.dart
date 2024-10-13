import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Widget child;
  void Function()? onClicked;
  ButtonStyle style;

  CustomElevatedButton(
      {required this.child, required this.onClicked, required this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: child,
      style: style,
    );
  }
}

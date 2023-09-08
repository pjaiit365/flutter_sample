import 'package:flutter/material.dart';
import 'package:pet_life_gh/constants.dart';

class DefaultBackButton extends StatelessWidget {
  Color backButtonColor;
  DefaultBackButton({this.backButtonColor = blue, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: backButtonColor,
        ));
  }
}

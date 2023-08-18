import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class PrimaryTextIconButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData iconData;
  final bool isDisabled;

  const PrimaryTextIconButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isDisabled = false,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Palette.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: Palette.white),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              child: Text(
                text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class DefaultTextIconButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData iconData;
  final bool isDisabled;

  const DefaultTextIconButton(
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
            border: Border.all(color: Palette.primaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: Palette.primaryColor),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                // side: const BorderSide(color: Palette.primaryColor),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Text(
                text,
                style: const TextStyle(color: Palette.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

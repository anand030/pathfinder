import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isStretched;
  final bool isDisabled;

  const DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isStretched= false,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Palette.primaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Text(
        text,
        style: const TextStyle(color: Palette.primaryColor),
      ),
    );
  }
}

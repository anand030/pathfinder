import 'package:flutter/material.dart';
import 'package:pathfinder/utilities/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isStretched;
  final bool isDisabled;

  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.isStretched = false,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: isStretched ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: CustomTextStyles().header(color: Colors.white),
        ),
      ),
    );
  }
}

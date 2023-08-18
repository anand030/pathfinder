import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  const BasicButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child);
  }
}

import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String text;
  final Widget icon;

  const StatusIndicator({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

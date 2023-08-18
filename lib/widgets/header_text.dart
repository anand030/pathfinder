import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final bool showBackButton;

  const HeaderText({Key? key, required this.text, this.showBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, top: 10),
      child: Row(
        children: [
          Visibility(
              visible: showBackButton,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          Text(
            text,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

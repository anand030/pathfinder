import 'package:flutter/material.dart';


class CircularProgressIndicatorPage extends StatelessWidget {
  const CircularProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.cyan,
      child: const CircularProgressIndicator(),
    );
  }
}

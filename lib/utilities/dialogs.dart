import 'package:flutter/material.dart';

showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

showAlertDialog(
  BuildContext context, {
  String title = 'Alert',
  required String message,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });
}

showActionAlertDialog(BuildContext context,
    {String title = 'Alert',
    required String message,
    required void Function() onTap}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(onPressed: onTap, child: const Text('Ok')),
          ],
        );
      });
}

showBottomSheetDialog(BuildContext context, Widget widget) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return widget;
    },
  );
}

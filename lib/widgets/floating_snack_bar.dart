import 'package:flutter/material.dart';
import 'package:pathfinder/utilities/text_styles.dart';

enum AlertType { Success, Failure }

class FloatingSnackBar extends StatelessWidget {
  final String message;
  final AlertType alertType;
  final void Function() onCloseClick;

  const FloatingSnackBar(
      {Key? key,
      required this.message,
      required this.alertType,
      required this.onCloseClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xFF9E6D8C), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        alertType == AlertType.Failure
            ? Icon(
                Icons.cancel,
                color: Colors.red,
              )
            : Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
        const SizedBox(
          width: 15,
        ),
        Text(
          message,
          style: CustomTextStyles().text(color: Colors.white),
        ),
        Spacer(),
        IconButton(
            onPressed: onCloseClick,
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ))
      ]),
    );
  }
}

import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

enum AvatarType { circular, squared }

enum AvatarStatus { away, available, active }

class StatusAvatar extends StatelessWidget {
  final Widget avatar;
  final Color backgroundColor;
  final AvatarType avtarType;
  final double size;
  final AvatarStatus avatarStatus;

  const StatusAvatar(
      {Key? key,
      this.avtarType = AvatarType.circular,
      required this.avatar,
      this.backgroundColor = Palette.primaryColor,
      this.size = 100,
      required this.avatarStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size,
          width: size,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  avtarType == AvatarType.squared ? 10 : size),
              border: Border.all(
                  color: avatarStatus == AvatarStatus.active
                      ? Colors.deepOrangeAccent
                      : avatarStatus == AvatarStatus.available
                          ? Colors.green
                          : Colors.red,
                  width: 3.5)),
        ),
        Container(
          height: size - 15,
          width: size - 15,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  avtarType == AvatarType.squared ? 10 : size),
              color: backgroundColor),
          child: avatar,
        ),
        Positioned(
          bottom: 10,
          right: 15,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: avatarStatus == AvatarStatus.active
                    ? Colors.deepOrangeAccent
                    : avatarStatus == AvatarStatus.available
                        ? Colors.green
                        : Colors.red,
                border: Border.all(width: 3, color: Colors.white)),
          ),
        )
      ],
    );
  }
}

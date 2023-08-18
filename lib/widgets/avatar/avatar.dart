import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

enum AvatarType { circular, squared }

class Avatar extends StatelessWidget {
  final Widget avatar;
  final Color backgroundColor;
  final AvatarType avtarType;

  const Avatar(
      {Key? key,
      this.avtarType = AvatarType.circular,
      required this.avatar,
      this.backgroundColor = Palette.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(avtarType == AvatarType.squared ? 10 : 50),
          color: backgroundColor),
      child: avatar,
    );
  }
}

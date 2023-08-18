import 'package:flutter/material.dart';

class TimelineModel {
  IconData? iconData;
  String? title;
  String? subtitle;

  TimelineModel(
      {this.iconData = Icons.circle_outlined,
      required this.title,
      required this.subtitle});
}

import 'package:flutter/material.dart';

import '../../utilities/text_styles.dart';

class EmptyDataScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const EmptyDataScreen(
      {Key? key,
      required this.image,
     required this.title ,
       this.description = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(45),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset('assets/images/$image',height: 150,),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: CustomTextStyles().header(),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: CustomTextStyles().text(),
        ),
      ],
    );
  }
}

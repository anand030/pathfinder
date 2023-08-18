import 'package:flutter/material.dart';
import 'package:introduction_slider/source/presentation/pages/introduction_slider.dart';
import 'package:introduction_slider/source/presentation/widgets/widgets.dart';

import '../onboarding/login_page.dart';

class IntroSlider extends StatelessWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      items: const [
        IntroductionSliderItem(
          logo: FlutterLogo(),
          title: Text("Title 1"),
          backgroundColor: Colors.red,
        ),
        IntroductionSliderItem(
          logo: FlutterLogo(),
          title: Text("Title 2"),
          backgroundColor: Colors.green,
        ),
        IntroductionSliderItem(
          logo: FlutterLogo(),
          title: Text("Title 3"),
          backgroundColor: Colors.yellow,
        ),
      ],
      done: const Done(
        child: Icon(Icons.done),
        home: LoginPage(),
      ),
      next: const Next(child: Icon(Icons.arrow_forward)),
      back: const Back(child: Icon(Icons.arrow_back)),
      dotIndicator: const DotIndicator(),
    );
  }
}

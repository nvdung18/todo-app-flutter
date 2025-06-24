import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeHeroWidget extends StatelessWidget {
  const WelcomeHeroWidget({super.key, this.height = 300, this.width = 300});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Hero(
        tag: 'welcome_hero',
        child: Lottie.asset(
          'assets/lotties/welcome.json',
          width: width,
          height: height,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatelessWidget {
  const LottieLoader._({
    required this.lottiePath,
    required this.controller,
    this.width = 200,
    this.height = 200,
    this.onLoaded,
  });

  /// Factory for splash screen
  factory LottieLoader.splash(
          {required Function(LottieComposition)? onLoaded, required AnimationController controller}) =>
      LottieLoader._(
        lottiePath: 'assets/animations/splash.json',
        controller: controller,
        width: 400,
        height: 400,
        onLoaded: onLoaded,
      );

  /// Factory for login button loader
  factory LottieLoader.login(
      {required Function(LottieComposition)? onLoaded, required AnimationController controller}) {
    return LottieLoader._(
      lottiePath: 'assets/animations/loading.json',
      controller: controller,
      width: 50,
      height: 50,
      onLoaded: onLoaded,
    );
  }

  final String lottiePath;
  final AnimationController controller;
  final double width;
  final double height;
  final Function(LottieComposition)? onLoaded;

  @override
  Widget build(BuildContext context) => Lottie.asset(
        lottiePath,
        controller: controller,
        width: width,
        height: height,
        onLoaded: onLoaded,
      );
}

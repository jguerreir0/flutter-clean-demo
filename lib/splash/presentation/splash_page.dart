import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydemo/routes.dart';
import 'package:mydemo/utils/lottie_loader/lottie_loader.dart';
import '../../login/presentation/bloc/auth_bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, homeRoute);
        } else {
          Navigator.pushReplacementNamed(context, loginRoute);
        }
      },
      child: Scaffold(
        body: Center(
          child: LottieLoader.splash(
            controller: _controller,
            onLoaded: (lottieComposition) {
              _controller.duration = lottieComposition.duration;
              _controller.forward().whenComplete(() {
                context.read<AuthBloc>().add(const OnAuthCheckRequested());
              });
            },
          ),
        ),
      ),
    );
  }
}

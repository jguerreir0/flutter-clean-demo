import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydemo/login/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:mydemo/routes.dart';
import 'package:mydemo/utils/lottie_loader/lottie_loader.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AnimationController _controller;

  @override
  void initState() {
    // Pre-fill the username and password for demonstration purposes
    _usernameController.text = 'emilys';
    _passwordController.text = 'emilyspass';
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authBloc = context.read<AuthBloc>();

      authBloc.add(OnLogin(_usernameController.text, _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _playCheck();
          Future.delayed(const Duration(milliseconds: 800), () {
            Navigator.pushReplacementNamed(context, homeRoute);
          });
        } else if (state is AuthFailure) {
          _resetAnimation();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg)),
          );
          _playLoopLoading();
        } else if (state is AuthInitial) {
          _resetAnimation();
          _playLoopLoading();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty ? 'Enter password' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => state.canSubmitLogin ? _performLogin(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _elevatedButtonChildBuilder(state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _elevatedButtonChildBuilder(AuthState state) {
    if (state.canSubmitLogin) {
      return const Text('Login', style: TextStyle(fontSize: 16, color: Colors.green));
    }
    return LottieLoader.login(
      controller: _controller,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        _playLoopLoading();
      },
    );
  }

  /// Play the check animation when login is successful
  void _playCheck() async {
    await _controller.animateTo(
      1.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
    );
  }

  /// Play the loading animation in a loop (not showing the check animation)
  void _playLoopLoading() {
    _controller.repeat(min: 0.0, max: 0.6);
  }

  void _resetAnimation() {
    _controller.reset();
  }
}

import 'package:flutter/material.dart';
import 'package:mydemo/di.dart';
import 'package:mydemo/routes.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zoom_app/pages/login.dart';
import 'package:zoom_app/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {'/login': (context) => LoginPage()},
      home: const LoginPage(),
    );
  }
}

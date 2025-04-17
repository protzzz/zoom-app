import 'package:flutter/material.dart';
import 'package:zoom_app/resources/auth_methods.dart';
import 'package:zoom_app/widgets/custom-button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Start or join a meeting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45),
            child: Image.asset('assets/images/onboarding.jpg'),
          ),
          CustomButton(
            text: 'Login',
            onPressed: () async {
              bool res = await _authMethods.signInWithGoogle(
                context,
              );
              if (res) {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
        ],
      ),
    );
  }
}

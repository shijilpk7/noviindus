import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noviindus/views/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_bg.png"), // your bg image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset("assets/images/logo.png", width: 120, height: 120),
        ),
      ),
    );
  }
}

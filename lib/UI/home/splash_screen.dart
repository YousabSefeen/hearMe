import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeAfterDelay();
  }

  void navigateToHomeAfterDelay() {
    Future.delayed(
      const Duration(seconds: 6),
      () {
        if (mounted) {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.network(
          'https://assets3.lottiefiles.com/packages/lf20_kbfzivr8.json',
        ),
      ),
    );
  }
}

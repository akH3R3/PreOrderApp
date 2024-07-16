import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:pre_order_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'P R E  O R D E R',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            const SizedBox(height: 20),
            Lottie.network(
              'https://lottie.host/9c4c2b05-1458-4c71-9985-26aeaf70faba/osZZ1105ck.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
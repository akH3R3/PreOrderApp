import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pre_order_app/screens/auth_screens/login_screen.dart';
import 'package:pre_order_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pre_order_app/screens/onboarding_screens/onboarding_screen.dart';
import 'package:pre_order_app/screens/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return SplashScreen();
          } else {
            return OnBoardingScreen();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'uihelper.dart';
import 'items_screen.dart'; // Create ItemsScreen for displaying items

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Navigate to ItemsScreen after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemsScreen()),
      );
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.mail, false),
          UiHelper.CustomTextField(passwordController, "Password", Icons.lock, true),
          SizedBox(height: 30),
          UiHelper.CustomButton(_login, "Login"),
        ],
      ),
    );
  }
}

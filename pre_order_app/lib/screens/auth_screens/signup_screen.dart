import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pre_order_app/screens/home_screen.dart';
import 'package:pre_order_app/widgets/my_appbar.dart';
import 'package:pre_order_app/widgets/my_button.dart';
import 'package:pre_order_app/widgets/my_textfield.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
      });

      print("Signed up: ${userCredential.user!.uid}");
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else {
        message = 'Error: ${e.message}';
      }
      _showErrorDialog(message);
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.green.shade400,
        title: Text('Success'),
        content: Text('Your account has been created successfully!'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          )
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(title: 'Sign Up'),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/preorder_signup.png',
                  height: 270,
                  width: 270,
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: MyTextfield(
                        'First Name', false, _firstNameController, null)),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: MyTextfield(
                        'Last Name', false, _lastNameController, null)),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: MyTextfield('Email', false, _emailController, null)),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: MyTextfield('Phone', false, _phoneController,
                        null)), // Add this line
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: MyTextfield(
                    'Password',
                    true,
                    _passwordController,
                    null,
                    obscureText: _obscurePassword,
                    toggleObscureText: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 5),
                MyButton(
                  text: 'Register',
                  onPressed: () {
                    _signUp();
                  },
                )
              ],
            ),
          ),
        ));
  }
}

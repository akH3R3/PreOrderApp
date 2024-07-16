import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pre_order_app/widgets/my_appbar.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();

    try {
      // Check if the email exists in the Firestore users collection
      final querySnapshot = await _firestore
          .collection('users') // Assuming you have a 'users' collection
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Email exists, send the password reset email
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Password reset email sent. Check your inbox.')),
        );
        Navigator.of(context).pop(); // Go back to login screen
      } else {
        // Email does not exist in Firestore
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No account found with this email.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else {
        message = 'An error occurred. Please try again later.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      // Handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Forget Password'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 7),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pink.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pink)),
                fillColor: const Color.fromARGB(255, 239, 226, 226),
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: 45,
                width: 175,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.purple],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateColor.transparent,
                  ),
                  onPressed: _isLoading ? null : _resetPassword,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 100,),
            Container(color: Colors.black,),
          ],
        ),
      ),
    );
  }
}

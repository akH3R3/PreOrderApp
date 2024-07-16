import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pre_order_app/screens/auth_screens/login_screen.dart';
import 'package:pre_order_app/widgets/my_appbar.dart';
import 'package:pre_order_app/widgets/my_button.dart';
import 'package:pre_order_app/widgets/my_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        setState(() {
          _nameController.text =
              userData['firstName'] + ' ' + userData['lastName'];
          _emailController.text = userData['email'];
          _phoneController.text = userData['phone'];
          _passwordController.text = userData['password'];
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'firstName': _nameController.text.split(' ')[0],
        'lastName': _nameController.text.split(' ').length > 1
            ? _nameController.text.split(' ')[1]
            : '',
        'email': _emailController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'bio': _bioController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.pink,),
      );
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'P R O F I L E'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage == null
                        ? AssetImage('assets/images/user_photo.jpeg')
                        : FileImage(_profileImage!) as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21, right: 21, bottom: 10),
                child: TextField(
                  controller: _bioController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Write something about yourself...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 3, bottom: 7),
                child: MyTextfield('Name', false, _nameController, null),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 3, bottom: 7),
                child: MyTextfield('Email', false, _emailController, null),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 3, bottom: 7),
                child: MyTextfield('Phone', false, _phoneController, null),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 3, bottom: 7),
                child: MyTextfield('Password', true, _passwordController, null),
              ),
              SizedBox(height: 5),
              MyButton(text: 'Save Profile', onPressed: _saveProfile),
              SizedBox(height: 12),
              MyButton(
                  text: 'Logout',
                  onPressed: () {
                    _logout();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

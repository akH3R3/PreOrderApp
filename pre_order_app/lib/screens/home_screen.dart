import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pre_order_app/widgets/my_appbar.dart';
import 'package:pre_order_app/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  String _firstName = '';

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_currentUser != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(_currentUser!.uid).get();
        setState(() {
          _firstName = userDoc['firstName'];
        });
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'H O M E   S C R E EN'),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome, $_firstName!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Lottie.network(
                  'https://lottie.host/4b3706a3-8850-45a4-bf7a-83b03debfeb5/qNUAxr2jEk.json',
                  height: 300,
                  width: 300),
                  SizedBox(height: 30,),
              Text(
                'Shopping List is waiting for you...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                'Go and Preorder lastest items in the maret.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pre_order_app/screens/auth_screens/login_screen.dart';
import 'package:pre_order_app/screens/feature_screens/preordered_screen.dart';
import 'package:pre_order_app/screens/feature_screens/shopping_screen.dart';
import 'package:pre_order_app/screens/home_screen.dart';
import 'package:pre_order_app/screens/profile_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

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
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 163, 126, 226),
        child: ListView(
          children: [
            DrawerHeader(
                child: Image.asset(
              'assets/images/drawer.png',
            )),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
              child: const ListTile(
               leading: Icon(Icons.home_outlined),
               title: Text('HOME',
               style: TextStyle(fontSize: 14)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
              },
              child: const ListTile(
               leading: Icon(Icons.person_outline),
               title: Text('PROFILE',
               style: TextStyle(fontSize: 14)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ShoppingScreen()));
              },
              child: const ListTile(
               leading: Icon(Icons.add_shopping_cart),
               title: Text('SHOPPING LIST',
               style: TextStyle(fontSize: 14)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PreorderedScreen()));
              },
              child: const ListTile(
               leading: Icon(Icons.shopping_cart_checkout),
               title: Text('PREORDERED LIST',
               style: TextStyle(fontSize: 14)),
              ),
            ),
            const SizedBox(height: 350,),
            GestureDetector(
              onTap: () {
                _logout();
              },
              child: const ListTile(
               leading: Icon(Icons.logout),
               title: Text('LOGOUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

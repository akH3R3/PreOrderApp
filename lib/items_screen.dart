import 'package:flutter/material.dart';
import 'uihelper.dart';

class ItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display your items here (you can fetch them from Firebase)
          // For demonstration, I'm using a simple example
          ListTile(
            title: Text("Iphone 15"),
            trailing: UiHelper.CustomButton(() {
              _preorderItem(context, "Iphone 15");
            }, "Preorder"),
          ),
          ListTile(
            title: Text("Iphone 15 pro"),
            trailing: UiHelper.CustomButton(() {
              _preorderItem(context, "Iphone 15 pro");
            }, "Preorder"),
          ),
          ListTile(
            title: Text("Iphone 16"),
            trailing: UiHelper.CustomButton(() {
              _preorderItem(context, "Iphone 16");
            }, "Preorder"),
          ),
          ListTile(
            title: Text("Iphone 16 pro"),
            trailing: UiHelper.CustomButton(() {
              _preorderItem(context, "Iphone 16 pro");
            }, "Preorder"),
          ),
          // Add more items as needed
        ],
      ),
    );
  }

  void _preorderItem(BuildContext context, String itemName) {
    // Display a dialog box or any other action you want
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Preorder"),
          content: Text("Preorder for $itemName is done!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

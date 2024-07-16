import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 5,
              colors: [Colors.pink, Colors.purple]),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}

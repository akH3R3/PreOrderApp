import 'package:flutter/material.dart';

TextField MyTextfield(
    String text,
    bool isPasswordType,
    TextEditingController controller,
    Icon? prefixIcon,
    {bool obscureText = true, Function()? toggleObscureText}) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType ? obscureText : false,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.pink,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(1)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.shade300,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
        borderRadius: BorderRadius.circular(10),
      ),
      suffixIcon: isPasswordType
          ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: toggleObscureText,
            )
          : null,
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

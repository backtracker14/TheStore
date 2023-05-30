import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  const MyTextBox(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 43, 120, 46)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 43, 120, 46)),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(120, 43, 120, 46)),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

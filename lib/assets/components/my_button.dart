import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String myButtonText;
  final double fontSize;

  const MyButton({
    super.key,
    required this.onTap,
    required this.myButtonText,
    this.fontSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width / 1.5, height / 15),
          elevation: 0,
          backgroundColor: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.red.shade900,
          ),
          Text(myButtonText,
              style: TextStyle(
                  color: Colors.red.shade900,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

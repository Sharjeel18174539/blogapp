import 'package:flutter/material.dart';
class AuthButton extends StatelessWidget {
  String text;
  final VoidCallback onPressed;
  AuthButton({required this.text, super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.purpleAccent,
              Colors.pinkAccent
            ],
            begin: Alignment.bottomLeft,
          end: Alignment.topRight
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      child: ElevatedButton(
          onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(395, 50),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
          child: Text(text, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),),
      ),
    );
  }
}

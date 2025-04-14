import 'package:flutter/material.dart';
class AuthField extends StatelessWidget {
  String text;
  final TextEditingController controller;
  final bool isObscureText;
   AuthField({ required this.text,required this.controller, super.key,  this.isObscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(18),
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0 , color: Colors.white60),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0 , color: Colors.pinkAccent),
          borderRadius: BorderRadius.circular(10),
        )
      ),
      validator: (value){
        if(value!.isEmpty){
          return "$text is missing";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}

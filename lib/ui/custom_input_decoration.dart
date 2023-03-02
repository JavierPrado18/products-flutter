import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration authInputDecoration({
    required String labelText,
    required String hintText,
    IconData? icon,
  }) {
    
    return  InputDecoration(
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
          color: Color(0xff2191FB),
          )
        ),
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff2191FB), width: 2)
        ),
        hintText: hintText,
        focusColor:const Color(0xff2191FB),
        labelText:labelText,
        labelStyle:const TextStyle(color: Color(0xff2191FB )) ,
        prefixIcon: Icon(icon,
          color:const Color(0xff2191FB),
        ));
  }
}

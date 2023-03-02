import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final String initialValue;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  
  const CustomTextForm({
    super.key, 
    required this.labelText, 
    required this.hintText, 
    required this.keyboardType, 
    required this.initialValue, 
    this.validator, 
    this.onChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      onChanged: onChanged,
      initialValue:initialValue ,
      keyboardType: keyboardType,
      validator: validator,
      decoration:InputDecoration(
        hintText:hintText,
        labelText: labelText,
      
      ),
    );
  }
}
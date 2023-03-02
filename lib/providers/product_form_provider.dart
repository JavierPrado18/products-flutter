import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  
  bool isAvailable=true;
  updateAvailable(bool value){
    isAvailable=value;
    notifyListeners();
  }

  bool isValid(){
    return formKey.currentState?.validate() ??false ;
    
  }
}
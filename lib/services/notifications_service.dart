import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey=GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message){
    Color color=Colors.red;
    String messageSnackBar='';
    //para mandar el mesaje segun el error
    if(message=='EMAIL_NOT_FOUND') {
      messageSnackBar='Correo no registrado';
    } else if(message=='INVALID_PASSWORD') {
      messageSnackBar='Contraseña invalida';
    }else if(message=='EMAIL_EXISTS'){
      messageSnackBar='El correo ya existe';
    }else{
      color=Colors.green;
      messageSnackBar='Bienvenido';
    }
    final snackBar=SnackBar(
      backgroundColor: color,
      content:Text(messageSnackBar,style:const TextStyle(color: Colors.white,fontSize: 20),) 
    );


    //llamamos nuestro messengerKey para mostrar el snackbar
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  
}
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class AuthService extends ChangeNotifier{
  final String _baseUrl='identitytoolkit.googleapis.com';
  final String _firebaseToken='AIzaSyDIVRK1pesQysu_VmfKFCrMao9VaRdGXek';

  //para guardar las credenciales en el securite-storage
  final storage=const FlutterSecureStorage();

  Future<String> createUser(String email,String password)async{
    final url=Uri.https(_baseUrl,'v1/accounts:signUp',{
      'key':_firebaseToken
    });
    
    //creamos un mapa con los parametros
    final Map<String,dynamic> authData={
      'email':email,
      'password':password,
      'returnSecureToken':true
    };
    //hacemos el post con el mapa encodificado en json
    final respose=await http.post(url,body: json.encode(authData));
    //decodificamos la respuesta del psot
    final Map<String,dynamic> decodeData=json.decode(respose.body);
    if(decodeData.containsKey('idToken')){
      return '';
    }else{
      print(decodeData['error']['message']);
      return decodeData['error']['message'];
    }
  }

  Future<String> login(String email,String password)async{
    final url=Uri.https(_baseUrl,'v1/accounts:signInWithPassword',{
      'key':_firebaseToken
    });
    
    //creamos un mapa con los parametros
    final Map<String,dynamic> authData={
      'email':email,
      'password':password,
      'returnSecureToken':true
    };
    //hacemos el post con el mapa encodificado en json
    final respose=await http.post(url,body: json.encode(authData));
    //decodificamos la respuesta del psot
    final Map<String,dynamic> decodeData=json.decode(respose.body);
    if(decodeData.containsKey('idToken')){
      //escribimos las credenciales en el storage
      await storage.write(key:'token', value: decodeData['idToken']);
      return '';
    }else{
      print(decodeData['error']['message']);
      return decodeData['error']['message'];
    }
  }
  
  //si el usuario quiere salir de su cuenta
  Future logout()async{
    await storage.delete(key:'token');
  }

  //verificr si tuenemos un token guardado
  Future<String> readToken()async{
    return await storage.read(key: 'token')??'';
  }

}
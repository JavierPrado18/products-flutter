import 'package:flutter/material.dart';
import 'package:formulario/screens/screens.dart';
import 'package:formulario/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context,listen: false);

    return Scaffold(
    
    body: Center(
     child:FutureBuilder(
      future: authService.readToken(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return const Center(child: CircularProgressIndicator(),);
        }
        
        if(snapshot.data=='' ){
          //se ejecuta tan proto se termine de contruir el widget
          Future.microtask(() {
            Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder:(context, animation, secondaryAnimation) => const LoginScreen(),
              transitionDuration:const Duration(seconds: 0)
            ));
          });

        }else{
          Future.microtask(() {
            Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder:(context, animation, secondaryAnimation) => const HomeScreen(), ));
          });
        }
        
        return Container();      
      },

     ),)
    );
  }
}
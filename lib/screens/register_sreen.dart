import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:formulario/providers/login_provider.dart';
import 'package:formulario/services/services.dart';
import 'package:formulario/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AuthBackground(),
          
          SingleChildScrollView(
            padding:const EdgeInsets.only(top: 170),
            child: Column(
              children: [
                ChangeNotifierProvider(
                  create: (context) => LoginProvider(),
                  child: const _FormContainer()),
                
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  }, 
                  child:const Text('¿Ya tienes cuenta?',style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffBA274A)
                    ),
                  )
                ),
                const SizedBox(height: 20,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormContainer extends StatelessWidget {
  const _FormContainer();

  @override
  Widget build(BuildContext context) {
    final loginProvider=Provider.of<LoginProvider>(context);

    return Container(
      margin: const EdgeInsets.all(30),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 10))
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        const Text('Crear cuenta',
          textAlign: TextAlign.center, 
          style: TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 39, 200, 197)
          )
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          //para conectar la key del provider con el form
          key: loginProvider.formKey,
      
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            
            CustomTextFormEmail(loginProvider: loginProvider),
            const SizedBox(
              height: 15,
            ),

            CustomTextFormPassword(loginProvider: loginProvider),
            const SizedBox(height: 20,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xff8CDEDC), 
                padding:const  EdgeInsets.symmetric(horizontal: 50)
              ),
              onPressed:loginProvider.isLoading?null: ()async {
                FocusScope.of(context).unfocus();
                final authService=Provider.of<AuthService>(context,listen: false);
                final productService=Provider.of<ProductsService>(context,listen: false);
                
                if(!loginProvider.isValidForm())return;
                
                loginProvider.isLoading=true;
                //llamamos el metodo para crear usuario
                final messageError=await authService.createUser(loginProvider.email,loginProvider.password); 
                if(messageError==''){
                  productService.updateData();
                  Navigator.pushReplacementNamed(context, 'home');

                }
                NotificationsService.showSnackbar(messageError);
                loginProvider.isLoading=false;

              }, 
              child:Text(loginProvider.isLoading?'Cargando':'Crear',style:const TextStyle(
                fontSize: 20,
                color: Color(0xffBA274A)),
              )
            )
          ],
        )),
      ]),
    );
  }
}



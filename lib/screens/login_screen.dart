import 'package:flutter/material.dart';
import 'package:formulario/providers/login_provider.dart';
import 'package:formulario/ui/custom_input_decoration.dart';
import 'package:formulario/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  onPressed: () {}, 
                  child:const Text('Crear cuenta',style: TextStyle(
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
        const Text('Login',
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
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: CustomInputDecoration.authInputDecoration(
                hintText: 'jonh.doe@gmail.com',
                labelText: 'email',
                icon: Icons.alternate_email_outlined),
              onChanged: (value) => loginProvider.email=value,
              validator: (value) {
                //expresion regular para validar si se trata de un email
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  =RegExp(pattern);
                //el value puede ser null
                return regExp.hasMatch(value??'')?null:'No es un correo';

              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: CustomInputDecoration.authInputDecoration(
                hintText: '*********',
                labelText: 'contraseña',
                icon: Icons.password),
              onChanged: (value) => loginProvider.password=value,
              validator: (value) {
                if(value!=null && value.length<=6) return 'Debe tener mas de 6 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xff8CDEDC), 
                padding:const  EdgeInsets.symmetric(horizontal: 50)
              ),
              onPressed:loginProvider.isLoading?null: ()async {
                FocusScope.of(context).unfocus();
                
                if(!loginProvider.isValidForm())return;
                
                loginProvider.isLoading=true;
                await Future.delayed(const Duration(seconds: 2));
                loginProvider.isLoading=false;

                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'home');
              }, 
              child:Text(loginProvider.isLoading?'Cargando':'Ingresar',style:const TextStyle(
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

import 'package:flutter/material.dart';
import 'package:formulario/providers/login_provider.dart';

import '../../ui/custom_input_decoration.dart';

class CustomTextFormEmail extends StatelessWidget {
  const CustomTextFormEmail({
    super.key,
    required this.loginProvider,
  });

  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

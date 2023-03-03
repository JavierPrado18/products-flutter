import 'package:flutter/material.dart';
import 'package:formulario/providers/login_provider.dart';

import '../../ui/custom_input_decoration.dart';

class CustomTextFormPassword extends StatelessWidget {
  const CustomTextFormPassword({
    super.key,
    required this.loginProvider,
  });

  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}

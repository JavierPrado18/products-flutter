import 'package:flutter/material.dart';

import 'package:formulario/models/poduct_model.dart';
import 'package:formulario/providers/product_form_provider.dart';
import 'custom_text_form.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.productForm,
    required this.product,
  });

  final ProductFormProvider productForm;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: productForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              CustomTextForm(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                onChanged: (value) => product.name = value,
                initialValue: product.name,
                hintText: 'Ejem:pelota',
                labelText: 'Nombre',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextForm(
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                validator: null,
                initialValue: product.price.toString(),
                hintText: '\$50.00',
                labelText: 'Precio',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              SwitchListTile.adaptive(
                  title: const Text('Disponible'),
                  value: productForm.isAvailable,
                  onChanged: (value) {
                    productForm.updateAvailable(value);
                    product.available = value;
                  })
            ],
          ),
        ));
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:formulario/models/poduct_model.dart';
import 'package:formulario/providers/product_form_provider.dart';
import 'package:formulario/services/products_service.dart';
import 'package:formulario/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //trae los valores de los argumentos
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    //trae el formkey el available
    final ProductFormProvider productForm =
        Provider.of<ProductFormProvider>(context);
    //llamamos el servicio para actualizar o crear un producto
    final productService = Provider.of<ProductsService>(context);

    //asignamos el product de los argumentos para poder manejar la imagen
    productService.product = product;

    //asignamos el Available de los argumentos y se lo asignamos al productform(provider para que cambie el switch)
    productForm.isAvailable = product.available;

    return Stack(children: [
      Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white70),
            child: Column(children: [
              
              _ImageContain(productService: productService),
              
              CustomForm(productForm: productForm, product: productService.product!),

              const SizedBox(
                height: 20,
              )
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!productForm.isValid()) return;

            final imgUrl = await productService.uploadImage();

            if (imgUrl != null) productService.product?.picture = imgUrl;
            await productService.createOrUpdateProduct(product);
          },
          child: const Icon(Icons.save_outlined),
        ),
      ),
      if (productService.isLoading == true)
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(181, 255, 255, 255),
          child: const Center(child: CircularProgressIndicator()),
        )
    ]);
  }
}


class _ImageContain extends StatelessWidget {
  final ProductsService productService;

  const _ImageContain({
    required this.productService,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: getImage(productService.product?.picture),
        ),
        Positioned(
            top: 25,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.black45,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            )),
        Positioned(
          top: 25,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
              color: Colors.black45,
            ),
            child: IconButton(
              onPressed: () async {
                //creamos la instancia de imagepicker
                final ImagePicker picker = ImagePicker();
                final photo =await picker.pickImage(source: ImageSource.camera);
                if (photo == null) return;
                //llamamos a updateimage para cambiar la url por el path(imagen)
                productService.updateSelectedImage(photo.path);
              },
              icon: const Icon(Icons.camera_alt_outlined,color: Colors.white,)
            ),
          )
        ),

        Positioned(
          top: 80,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
              color: Colors.black45,
            ),
            child: IconButton(
              onPressed: () async {
                //creamos la instancia de imagepicker
                final ImagePicker picker = ImagePicker();
                final image =await picker.pickImage(source: ImageSource.gallery);
                if (image == null) return;
                //llamamos a updateimage para cambiar la url por el path(imagen)
                productService.updateSelectedImage(image.path);
              },
              icon: const Icon(Icons.image,color: Colors.white,)
            ),
          )
        )
      ]),
    );
  }

//para obtener la imagen segun null http o path
  Widget getImage(String? image) {
    if (image == null) {
      return const Image(
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          image: AssetImage('assets/no-image.jpg'));
    } else if (image.startsWith('http')) {
      return FadeInImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(image));
    }
    return Image.file(
      width: double.infinity,
      height: double.infinity,
      File(image),
      fit: BoxFit.cover,
    );
  }
}

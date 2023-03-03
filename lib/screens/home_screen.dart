import 'package:flutter/material.dart';
import 'package:formulario/services/auth_service.dart';

import 'package:provider/provider.dart';

import 'package:formulario/models/poduct_model.dart';
import 'package:formulario/services/products_service.dart';
import 'package:formulario/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final products=Provider.of<ProductsService>(context);
    final authService=Provider.of<AuthService>(context,listen: false);
    products.getProducts;
    return Scaffold(
    appBar:AppBar(
    title:const Text('Productos'),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: (){
          authService.logout();
          Navigator.pushReplacementNamed(context, 'login');
        }, 
        icon:const Icon(Icons.logout))
    ],
    ),
    
    body:products.isLoading?const CircularProgressIndicator() 
      :ListView.builder(
      itemCount: products.products.length,
      itemBuilder: (BuildContext context, int index) {
        final product=products.products[index];
        
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'product',arguments: product);
          },
          child: ProductCard(
            available: product.available,
            name: product.name,
            picture: product.picture,
            price: product.price,
            id: product.id,
          )) ;
      },
    ),
    floatingActionButton: FloatingActionButton(
      child:const Icon(Icons.add),
      onPressed: (){
        final newProduct=Product(available: false,name: '',price: 0);
        Navigator.pushNamed(context, 'product',arguments: newProduct);
      },
    ),
    );
  }
}
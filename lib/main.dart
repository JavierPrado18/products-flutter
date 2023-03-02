import 'package:flutter/material.dart';
import 'package:formulario/providers/product_form_provider.dart';
import 'package:formulario/screens/screens.dart';
import 'package:formulario/services/products_service.dart';
import 'package:formulario/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsService(),lazy: false,),
        ChangeNotifierProvider(create: (context) => ProductFormProvider(),)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeLigth,
      title: 'Formulario',
      initialRoute: 'home',
      routes: {
        'login':(context) => const LoginScreen(),
        'home':(context) => const HomeScreen(),
        'product':(context) => const ProductScreen(),
      },
    );
  }
}
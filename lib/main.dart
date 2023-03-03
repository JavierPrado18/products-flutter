import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:formulario/providers/product_form_provider.dart';
import 'package:formulario/screens/screens.dart';
import 'package:formulario/services/services.dart';
import 'package:formulario/theme/app_theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsService(),),
        ChangeNotifierProvider(create: (context) => ProductFormProvider(),),
        ChangeNotifierProvider(create: (context) => AuthService(),)
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
      title: 'App de Productos',
      initialRoute: 'checking',
      routes: {
        'checking':(context) => const CheckAuthScreen(),
        'login':(context) => const LoginScreen(),
        'home':(context) => const HomeScreen(),

        'product':(context) => const ProductScreen(),
        'register':(context) => const RegisterScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
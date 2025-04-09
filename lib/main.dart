import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/providers/cart_summary_provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),

        /// ProxyProvider listens to CartProvider and updates CartSummary
        ChangeNotifierProxyProvider<CartProvider, CartSummaryProvider>(
          create: (_) => CartSummaryProvider(),
          update: (_, cart, summary) => summary!..updateFromCart(cart),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}

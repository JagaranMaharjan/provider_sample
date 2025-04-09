import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_detail_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailProvider()..fetchProduct(productId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: Consumer<ProductDetailProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text('Error: ${provider.error}'));
            }

            final product = provider.product;
            if (product == null) {
              return const Center(child: Text('No product found.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.thumbnail, height: 200, fit: BoxFit.cover),
                  const SizedBox(height: 16),
                  Text(product.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('\$${product.price}', style: const TextStyle(fontSize: 18, color: Colors.green)),
                  const SizedBox(height: 16),
                  Text(product.description, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

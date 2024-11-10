import 'package:flutter/material.dart';
import 'package:khemputhsela_store/handler_cart.dart';
import 'package:khemputhsela_store/cart_list_screen.dart';
import 'package:khemputhsela_store/main.dart';
import 'package:khemputhsela_store/product.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartListScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              urlApi + product.image,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text("Total: \$${product.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 16)),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<HandlerCart>(context, listen: false).addItem(product);
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

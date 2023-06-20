import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:museum/models/product.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const EmarketApp());
}

class EmarketApp extends StatelessWidget {
  const EmarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Artwork(),
    );
  }
}

class Artwork extends StatefulWidget {
  const Artwork({super.key});

  @override
  State<Artwork> createState() => _Artwork();
}

class _Artwork extends State<Artwork> {
  List<Product> parseProduct(String responseBody) {
    final parsed = jsonDecode(responseBody)['products'];

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchProduct(http.Client client) async {
    final response =
        await client.get(Uri.parse('https://dummyjson.com/products'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return parseProduct(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phones market"),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //print(snapshot.error);
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ProductList(products: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(products[index].title),
            Image.network(products[index].thumbnail),
            Text('${products[index].price.toString()} €'),
            Text(products[index].description),
          ],
        );
      },
    );
  }
}

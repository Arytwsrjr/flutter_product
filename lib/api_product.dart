import 'dart:convert';

import 'package:http/http.dart' as http;

import '/product.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8001/products";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<void> addProduct(Product product) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
  }

  static Future<void> updateProduct(Product product) async {
    if (product.id == 0) {
      throw Exception("Invalid Product ID");
    }
    final response = await http.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "name": product.name,
        "description": product.description,
        "price": product.price
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update product");
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}

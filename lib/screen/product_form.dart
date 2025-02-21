import 'package:flutter/material.dart';
import '/api_product.dart';
import '/product.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  final VoidCallback onSave;

  const ProductFormScreen({super.key, this.product, required this.onSave});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price.toString() ?? '');
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      Product product = Product(
        id: widget.product?.id ?? 0,
        name: _nameController.text,
        description: _descController.text,
        price: double.parse(_priceController.text),
      );

      if (widget.product == null) {
        await ApiService.addProduct(product);
      } else {
        await ApiService.updateProduct(product);
      }

      widget.onSave();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product saved successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name")),
              TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: "Description")),
              TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: "Price")),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _saveProduct, child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}

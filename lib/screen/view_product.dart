import 'package:app_sqlite_trabalho/model/product.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  final Product product;

  const ViewProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visualizar Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Detalhes do Produto",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const Divider(
                  color: Colors.indigo,
                  height: 30,
                  thickness: 1.5,
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  leading: const Icon(Icons.shopping_bag, color: Colors.indigo),
                  title: const Text(
                    'Nome',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(
                    widget.product.name ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  leading: const Icon(Icons.branding_watermark, color: Colors.indigo),
                  title: const Text(
                    'Marca',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(
                    widget.product.brand ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  leading: const Icon(Icons.attach_money, color: Colors.indigo),
                  title: const Text(
                    'Preço',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(
                    widget.product.price.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

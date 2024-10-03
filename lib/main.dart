import 'package:app_sqlite_trabalho/model/product.dart';
import 'package:app_sqlite_trabalho/screen/add_product.dart';
import 'package:app_sqlite_trabalho/screen/edit_product.dart';
import 'package:app_sqlite_trabalho/screen/view_product.dart';
import 'package:app_sqlite_trabalho/services/product_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciar produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Product> _productList = <Product>[];
  final _productService = ProductService();

  getAllProductDetails() async {
    var products = await _productService.readAllProducts();
    setState(() {
      _productList = <Product>[];
      products.forEach((user) {
        var productModel = Product();
        productModel.id = user['id'];
        productModel.name = user['name'];
        productModel.brand = user['brand'];
        productModel.price = user['price'];
        _productList.add(productModel);
      });
    });
  }

  @override
  void initState() {
    getAllProductDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  _deleteFormDialog(BuildContext context, productId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Deseja Realmente Excluir?',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _productService.deleteProduct(productId);
                    Navigator.pop(context);
                    getAllProductDetails();
                    _showSuccessSnackBar('Produto Excluído com Sucesso!');
                  },
                  child: const Text('Excluir')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar produtos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewProduct(
                                  product: _productList[index],
                                )));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: Text(
                      _productList[index].name![0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    _productList[index].name ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Marca: ${_productList[index].brand ?? ''}"),
                      Text("Preço: ${_productList[index].price ?? ''}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProduct(
                                          product: _productList[index],
                                        ))).then((data) {
                              if (data != null) {
                                getAllProductDetails();
                                _showSuccessSnackBar(
                                    'Produto Alterado com Sucesso!');
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {
                            _deleteFormDialog(context, _productList[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddProduct()))
              .then((data) {
            if (data != null) {
              getAllProductDetails();
              _showSuccessSnackBar('Produto Adicionado com Sucesso!');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

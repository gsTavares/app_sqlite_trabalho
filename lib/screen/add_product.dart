import 'package:app_sqlite_trabalho/model/product.dart';
import 'package:app_sqlite_trabalho/services/product_service.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _productNameController = TextEditingController();
  final _productBrandController = TextEditingController();
  final _productPriceController = TextEditingController();
  bool _validateName = false;
  bool _validateBrand = false;
  bool _validatePrice = false;
  final _userService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar produto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cadastrar Produto',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.shopping_bag, color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.indigo),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.indigoAccent),
                  ),
                  hintText: 'Nome do Produto',
                  labelText: 'Nome',
                  errorText: _validateName ? 'Nome não pode ser vazio' : null,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _productBrandController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.branding_watermark, color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.indigo),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.indigoAccent),
                  ),
                  hintText: 'Marca do Produto',
                  labelText: 'Marca',
                  errorText: _validateBrand ? 'Marca não pode ser vazia' : null,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.attach_money, color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.indigo),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.indigoAccent),
                  ),
                  hintText: 'Preço',
                  labelText: 'Preço',
                  errorText: _validatePrice ? 'Preço não pode ser vazio' : null,
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _productNameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _productBrandController.text.isEmpty
                            ? _validateBrand = true
                            : _validateBrand = false;
                        _productPriceController.text.isEmpty
                            ? _validatePrice = true
                            : _validatePrice = false;
                      });
                      if (!_validateName && !_validateBrand && !_validatePrice) {
                        var _product = Product();
                        _product.name = _productNameController.text;
                        _product.brand = _productBrandController.text;
                        _product.price = _productPriceController.text;
                        var result = await _userService.SaveProduct(_product);
                        Navigator.pop(context, result);
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.clear),
                    label: const Text('Limpar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _productNameController.clear();
                      _productBrandController.clear();
                      _productPriceController.clear();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
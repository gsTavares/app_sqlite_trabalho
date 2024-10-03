import 'package:app_sqlite_trabalho/model/product.dart';
import 'package:app_sqlite_trabalho/services/product_service.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _productNameController = TextEditingController();
  final _productBrandController = TextEditingController();
  final _productPriceController = TextEditingController();
  bool _validateName = false;
  bool _validateBrand = false;
  bool _validatePrice = false;
  final _productService = ProductService();

  @override
  void initState() {
    _productNameController.text = widget.product.name ?? '';
    _productBrandController.text = widget.product.brand ?? '';
    _productPriceController.text = widget.product.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar produto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Produto',
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
                    label: const Text('Editar'),
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
                        var updatedProduct = Product();
                        updatedProduct.id = widget.product.id;
                        updatedProduct.name = _productNameController.text;
                        updatedProduct.brand = _productBrandController.text;
                        updatedProduct.price = _productPriceController.text;
                        var result = await _productService.UpdateProduct(updatedProduct);
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

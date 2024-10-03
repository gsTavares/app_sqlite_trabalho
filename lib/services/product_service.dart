import 'dart:async';

import 'package:app_sqlite_trabalho/db_helper/repository.dart';
import 'package:app_sqlite_trabalho/model/product.dart';

class ProductService {
  late Repository _repository;
  ProductService() {
    _repository = Repository();
  }

  SaveProduct(Product product) async {
    return await _repository.insertData('products', product.productMap());
  }

  readAllProducts() async {
    return await _repository.readData('products');
  }

  UpdateProduct(Product product) async {
    return await _repository.updateData('products', product.productMap());
  }

  deleteProduct(productId) async {
    return await _repository.deleteDataById('products', productId);
  }
}

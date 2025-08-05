

import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/domain/repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}

import 'package:ecommerse_app/features/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
}

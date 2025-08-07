// Abstract repository for product operations, defining the contract for product data access.
// Decouples data sources from business logic and enables easy mocking for tests.
import 'package:ecommerse_app/features/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
}

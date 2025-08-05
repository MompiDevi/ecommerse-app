import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';

class RemoveCart{
  final CartRepository repository;

  RemoveCart({required this.repository});
  Future<Cart> call({required int productId}){
    return repository.removeItemFromCart(productId);
  }
}
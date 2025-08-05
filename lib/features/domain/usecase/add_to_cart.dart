import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';

class AddToCart{
  final CartRepository repository;

  AddToCart({required this.repository});
  Future<void> call({required Cart cart}){
    return repository.addToCart(cart);
  }
}
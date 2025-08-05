import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';

class UpdateCart{
  final CartRepository repository;

  UpdateCart({required this.repository});
  Future<void> call({required int productId, required int quantity}){
    return repository.updateCartItemQuantity(productId, quantity);
  }
}
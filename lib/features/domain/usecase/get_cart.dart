import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';

class GetCart{
  final CartRepository repository;

  GetCart({required this.repository});
  Future<Cart> call({required int userId}){
    return repository.getCartById(userId);
  }
}
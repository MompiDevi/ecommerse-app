import 'dart:convert';

import 'package:ecommerse_app/features/data/models/cart_model.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:http/http.dart' as http;
class CartRemoteDataSource{

  Future<CartModel> getCartById(int id) async {
    final response = await http.get(Uri.parse("https://fakestoreapi.com/carts/$id"));
    if(response.statusCode == 200){
      try{
        return CartModel.fromJson(response.body);
      }catch(e){
        throw Exception(e.toString());
      }
      
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addToCart(CartModel model) async {
    final response = await http.post(Uri.parse('https://fakestoreapi.com/carts'), body: model.toJson());
    if(response.statusCode != 200){
      throw Exception(response.reasonPhrase);
    }
  }

  Future<CartModel> removeItemFromCart(int productId) async {
  final response = await http.delete(
    Uri.parse('https://fakestoreapi.com/carts/1'),
    headers: {"Content-Type": "application/json"},
  );

  if(response.statusCode == 200){
      try{
        return CartModel.fromJson(response.body);
      }catch(e){
        throw Exception(e.toString());
      }
      
    } else {
      throw Exception(response.reasonPhrase);
    }
}

Future<void> updateCartItemQuantity(int productId, int quantity) async {
  final response = await http.put(
    Uri.parse('https://fakestoreapi.com/carts/1'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({'productId':productId,'quantity': quantity,}),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update quantity');
  }
}

}
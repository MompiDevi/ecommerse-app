import 'package:bloc/bloc.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/usecase/add_to_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/get_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/remove_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/update_cart.dart';
import 'package:meta/meta.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveCart removeCart;
  final UpdateCart updateCart; 
  CartBloc(this.getCart, this.addToCart, this.removeCart, this.updateCart) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      try{
        final cartData = await getCart(userId: event.userId);
        emit(CartLoaded(cart: cartData));
      } catch (e){
        emit(CartError(message: e.toString()));
      }
      
    });

    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());
       try{
        await addToCart(cart: event.cart);
        emit(ItemAddedToCart());
      } catch (e){
        emit(CartError(message: e.toString()));
      }
    });

    on<RemoveFromCart>((event, emit) async {
      emit(CartLoading());
      try{
        final cartData = await removeCart(productId: event.productId);
        emit(CartLoaded(cart: cartData));
      } catch (e){
        emit(CartError(message: e.toString()));
      }
    });


   on<UpdateCartItemQuantity>((event, emit) async { 
    emit(CartLoading());
      try {
        await updateCart(productId: event.productId, quantity: event.newQuantity);
        final cartData = await getCart(userId: event.userId);
        emit(CartLoaded(cart: cartData));
      } catch (e) {
        emit(CartError(message: 'Failed to update cart item quantity.'));
      }
    });

  }
}

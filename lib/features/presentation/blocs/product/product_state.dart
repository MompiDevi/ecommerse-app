part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasMore;
  ProductLoaded(this.products, {this.hasMore = true});
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
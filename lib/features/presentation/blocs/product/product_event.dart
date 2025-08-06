part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}
class LoadProductsEvent extends ProductEvent {}
class LoadMoreProductsEvent extends ProductEvent {}
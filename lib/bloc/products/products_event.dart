part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class GetSingleProductEvent extends ProductsEvent {
  final int id;

  GetSingleProductEvent({required this.id});
}

class LoadMoreProductEvent extends ProductsEvent {
  final int offset;
  final int limit;

  LoadMoreProductEvent({required this.offset, required this.limit});
}

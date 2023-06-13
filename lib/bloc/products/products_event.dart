part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class GetSingleProductEvent extends ProductsEvent {
  final int id;

  GetSingleProductEvent({required this.id});
}

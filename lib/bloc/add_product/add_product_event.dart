part of 'add_product_bloc.dart';

abstract class AddProductEvent {}

class DoAddProductEvent extends AddProductEvent {
  final ProductRequestModel model;
  DoAddProductEvent({
    required this.model,
  });
}

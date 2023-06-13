// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_product_bloc.dart';

abstract class EditProductEvent {}

class DoEditProductEvent extends EditProductEvent {
  final EditProductRequestModel model;
  final int id;
  DoEditProductEvent({
    required this.model,
    required this.id,
  });
}

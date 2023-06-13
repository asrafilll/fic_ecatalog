// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_product_bloc.dart';

abstract class EditProductState {}

class EditProductInitial extends EditProductState {}

class EditProductLoading extends EditProductState {}

class EditProductSuccess extends EditProductState {
  final ProductResponseModel data;
  EditProductSuccess({
    required this.data,
  });
}

class EditProductFailed extends EditProductState {
  final String errorMessage;

  EditProductFailed({
    required this.errorMessage,
  });
}

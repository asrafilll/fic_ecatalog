part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

enum Status {
  initial,
  loading,
  success,
  error,
}

class ProductsLoaded extends ProductsState {
  final List<ProductResponseModel> data;

  Status? status;
  int? page = 0;
  int? size = 10;
  bool? hasMore = true;

  ProductsLoaded({
    required this.data,
    this.status,
    this.page,
    this.size,
    this.hasMore,
  });

  ProductsLoaded copyWith({
    List<ProductResponseModel>? data,
    Status? status,
    int? page,
    int? size,
    bool? hasMore,
  }) {
    return ProductsLoaded(
      data: data ?? this.data,
      status: status ?? this.status,
      page: page ?? this.page,
      size: size ?? this.size,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError({
    required this.message,
  });
}

class SingleProductLoaded extends ProductsState {
  final ProductResponseModel data;
  SingleProductLoaded({
    required this.data,
  });
}

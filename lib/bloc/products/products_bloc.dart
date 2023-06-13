import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSource dataSource;
  ProductsBloc(
    this.dataSource,
  ) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await dataSource.getAllProduct();
      result.fold(
        (error) => emit(ProductsError(message: error)),
        (result) => emit(ProductsLoaded(data: result)),
      );
    });

    on<GetSingleProductEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await dataSource.getSingleProduct(event.id);

      result.fold(
        (error) => emit(ProductsError(message: error)),
        (result) => emit(SingleProductLoaded(data: result)),
      );
    });

    on<LoadMoreProductEvent>((event, emit) async {
      final currentState = state as ProductsLoaded;
      emit(
        currentState.copyWith(status: Status.loading),
      );
      final result =
          await dataSource.loadMoreProduct(event.offset, event.limit);
      final currentPage = currentState.page ?? 0;
      final nextPage = currentPage + 1;

      var hasMore = currentState.hasMore ?? false;
      result.fold(
          (l) => emit(ProductsError(message: l)),
          (r) => emit(
                ProductsLoaded(
                  data: currentState.data + r,
                  status: currentState.status,
                  page: nextPage,
                  size: currentState.size,
                  hasMore: hasMore && r.length > (currentState.size ?? 0),
                ),
              ));
    });
  }
}

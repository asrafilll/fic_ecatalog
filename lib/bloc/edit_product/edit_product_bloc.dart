import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/edit_product_request_model.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final ProductDataSource dataSource;
  EditProductBloc(this.dataSource) : super(EditProductInitial()) {
    on<DoEditProductEvent>((event, emit) async {
      emit(EditProductLoading());
      final result = await dataSource.editProduct(event.model, event.id);
      result.fold(
        (l) => emit(EditProductFailed(errorMessage: l)),
        (r) => emit(EditProductSuccess(data: r)),
      );
    });
  }
}

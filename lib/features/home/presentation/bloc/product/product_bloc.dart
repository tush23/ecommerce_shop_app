import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/filter_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final FilterProducts filterProducts;

  // Pagination variables
  static const int _pageSize = 10;

  ProductBloc({
    required this.getProducts,
    required this.filterProducts,
  }) : super(ProductInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<FilterProductsEvent>(_onFilterProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;

    // If we're initially loading or refreshing
    if (currentState is ProductInitial || (event.offset == null || event.offset == 0)) {
      emit(ProductLoading());

      final result = await getProducts(limit: event.limit ?? _pageSize, offset: 0);

      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (products) => emit(ProductsLoaded(products, hasReachedMax: products.length < _pageSize)),
      );
    } else if (currentState is ProductsLoaded && !currentState.hasReachedMax) {
      // Load next page
      final result = await getProducts(
        limit: _pageSize,
        offset: currentState.products.length,
      );

      result.fold(
        (failure) => emit(ProductError(failure.message)),
        (newProducts) {
          final allProducts = [...currentState.products, ...newProducts];
          emit(currentState.copyWith(
            products: allProducts,
            hasReachedMax: newProducts.length < _pageSize,
          ));
        },
      );
    }
  }

  Future<void> _onFilterProducts(
    FilterProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await filterProducts(event.query);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProducts(limit: _pageSize, offset: 0);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductsLoaded(products, hasReachedMax: products.length < _pageSize)),
    );
  }
}

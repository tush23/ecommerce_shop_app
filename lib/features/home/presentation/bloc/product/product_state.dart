import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductsLoaded(this.products, {this.hasReachedMax = false});

  @override
  List<Object> get props => [products, hasReachedMax];

  ProductsLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return ProductsLoaded(
      products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final int? limit;
  final int? offset;

  GetProductsEvent({this.limit, this.offset});

  @override
  List<Object> get props => [limit ?? 0, offset ?? 0];
}

class FilterProductsEvent extends ProductEvent {
  final String query;

  FilterProductsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class RefreshProductsEvent extends ProductEvent {}

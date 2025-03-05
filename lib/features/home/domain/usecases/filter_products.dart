import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class FilterProducts {
  final ProductRepository repository;

  FilterProducts(this.repository);

  Future<Either<Failure, List<Product>>> call(String query) {
    return repository.filterProducts(query);
  }
}

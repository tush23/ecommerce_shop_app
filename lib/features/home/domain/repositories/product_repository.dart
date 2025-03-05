import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({int? limit, int? offset});
  Future<Either<Failure, List<Product>>> filterProducts(String query);
}

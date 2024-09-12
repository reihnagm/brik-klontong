import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/product/data/models/product.dart';
import 'package:brik/features/product/domain/repositories/product_repository.dart';

import 'package:dartz/dartz.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> execute({
    required String search,
    required int skip,
    required int limit
  }) {
    return repository.getProducts(
      search: search,
      skip: skip,
      limit: limit
    );
  }
}
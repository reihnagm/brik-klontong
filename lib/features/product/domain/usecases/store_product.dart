import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/product/domain/repositories/product_repository.dart';

import 'package:dartz/dartz.dart';

class StoreProductUseCase {
  final ProductRepository repository;

  StoreProductUseCase(this.repository);

  Future<Either<Failure, void>> execute({required String title}) {
    return repository.storeProduct(title: title);
  }
}
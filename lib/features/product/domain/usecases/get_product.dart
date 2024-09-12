import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/product/data/models/product_detail.dart';
import 'package:brik/features/product/domain/repositories/product_repository.dart';

import 'package:dartz/dartz.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<Either<Failure, ProductDetail>> execute({required String id}) {
    return repository.getProduct(id: id);
  }
}
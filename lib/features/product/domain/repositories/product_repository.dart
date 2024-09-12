import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/product/data/models/product.dart';
import 'package:brik/features/product/data/models/product_detail.dart';

import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    required String search,
    required int limit,
    required int skip
  });
  Future<Either<Failure, ProductDetail>> getProduct({required String id});
}
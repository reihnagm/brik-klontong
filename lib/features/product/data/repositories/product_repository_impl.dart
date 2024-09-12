import 'package:dartz/dartz.dart';

import 'package:brik/features/product/data/datasources/product_remote_data_souce.dart';
import 'package:brik/features/product/data/models/product.dart';
import 'package:brik/features/product/data/models/product_detail.dart';

import 'package:brik/features/product/domain/repositories/product_repository.dart';

import 'package:brik/common/errors/exception.dart';
import 'package:brik/common/errors/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    required String search,
    required int skip,
    required int limit
  }) async {
    try {
      var result = await remoteDataSource.getProducts(
        search: search,
        skip: skip,
        limit: limit
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetail>> getProduct({required String id}) async {
    try {
      var result = await remoteDataSource.getProduct(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storeProduct({required String title}) async {
    try {
      var result = await remoteDataSource.storeProduct(title: title);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

}
import 'package:dartz/dartz.dart';

import 'package:brik/common/errors/exception.dart';
import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/auth/data/datasources/auth_remote_data_souce.dart';
import 'package:brik/features/auth/data/models/auth.dart';
import 'package:brik/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthModel>> login({
    required String email, 
    required String password
  }) async {
    try {
      var result = await remoteDataSource.login(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> register({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      var result = await remoteDataSource.register(
        fullname: fullname,
        email: email, 
        password: password
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }


}
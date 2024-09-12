import 'package:brik/features/user/data/models/profile/profile.dart';
import 'package:dartz/dartz.dart';

import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/user/data/datasources/user_remote_data_source.dart';
import 'package:brik/features/user/data/models/user_activity/user_activity.dart';
import 'package:brik/features/user/domain/repositories/user_repository.dart';

import 'package:brik/common/errors/exception.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserActivityModel>> getListUserActivity() async {
     try {
      var result = await remoteDataSource.getListUserActivity();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
     try {
      var result = await remoteDataSource.getProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

}
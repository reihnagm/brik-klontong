import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/user/data/models/user_activity/user_activity.dart';

import 'package:brik/features/user/domain/repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class GetListUserActivityUseCase {
  final UserRepository repository;

  GetListUserActivityUseCase(this.repository);

  Future<Either<Failure, UserActivityModel>> execute() {
    return repository.getListUserActivity();
  }
}
import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/user/data/models/profile/profile.dart';
import 'package:brik/features/user/domain/repositories/user_repository.dart';

import 'package:dartz/dartz.dart';

class GetProfileUseCase {
  final UserRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileModel>> execute() {
    return repository.getProfile();
  }
}
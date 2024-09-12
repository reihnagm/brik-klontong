import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/auth/data/models/auth.dart';
import 'package:brik/features/auth/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthModel>> execute({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
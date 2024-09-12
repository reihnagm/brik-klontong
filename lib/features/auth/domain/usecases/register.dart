
import 'package:brik/common/errors/failure.dart';
import 'package:brik/features/auth/data/models/auth.dart';
import 'package:brik/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthModel>> execute({
    required String fullname,
    required String email,
    required String password,
  }) {
    return repository.register(
      fullname: fullname,
      email: email, 
      password: password
    );
  }
}
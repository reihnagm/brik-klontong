import 'package:brik/common/errors/failure.dart';
import 'package:brik/features/auth/data/models/auth.dart';

import 'package:dartz/dartz.dart';

abstract class AuthRepository {
   Future<Either<Failure, AuthModel>> login({
    required String email, 
    required String password
  });
  Future<Either<Failure, AuthModel>> register({
    required String fullname,
    required String email,
    required String password
  });
}
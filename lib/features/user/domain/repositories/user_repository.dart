import 'package:brik/common/errors/failure.dart';

import 'package:brik/features/user/data/models/profile/profile.dart';
import 'package:brik/features/user/data/models/user_activity/user_activity.dart';

import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserActivityModel>> getListUserActivity();
  Future<Either<Failure, ProfileModel>> getProfile();
}
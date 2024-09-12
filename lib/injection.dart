import 'package:brik/features/product/domain/usecases/get_product.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:brik/common/helpers/dio.dart';

import 'package:brik/features/auth/data/datasources/auth_remote_data_souce.dart';
import 'package:brik/features/auth/data/repositories/auth_repository_impl.dart';

import 'package:brik/features/auth/domain/repositories/auth_repository.dart';
import 'package:brik/features/auth/domain/usecases/login.dart';
import 'package:brik/features/auth/domain/usecases/register.dart';

import 'package:brik/features/auth/presentation/provider/login_notifier.dart';
import 'package:brik/features/auth/presentation/provider/register_notifier.dart';

import 'package:brik/features/product/domain/repositories/product_repository.dart';
import 'package:brik/features/product/presentation/provider/get_product_notifier.dart';
import 'package:brik/features/product/domain/usecases/get_products.dart';
import 'package:brik/features/product/presentation/provider/get_products_notifier.dart';
import 'package:brik/features/product/data/datasources/product_remote_data_souce.dart';
import 'package:brik/features/product/data/repositories/product_repository_impl.dart';

final locator = GetIt.instance;

void init() {

  // REMOTE DATA SOURCE 
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(client: locator()));

  // REPOSITORY 
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(remoteDataSource: locator()));

  // USE CASE
  locator.registerLazySingleton(() => RegisterUseCase(locator()));
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => GetProductsUseCase(locator()));
  locator.registerLazySingleton(() => GetProductUseCase(locator()));

  // NOTIFIER
  locator.registerFactory(() => RegisterNotifier(registerUseCase: locator()));
  locator.registerFactory(() => LoginNotifier(loginUseCase: locator()));
  locator.registerFactory(() => GetProductsNotifier(getProductsUseCase: locator()));
  locator.registerFactory(() => GetProductNotifier(getProductUseCase: locator()));

  DioHelper dio = DioHelper();
  Dio getDio = dio.getClient();

  locator.registerLazySingleton(() => getDio);
}

import 'package:brik/features/product/domain/usecases/store_product.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:brik/common/helpers/dio.dart';

import 'package:brik/features/product/data/repositories/product_repository_impl.dart';

import 'package:brik/features/product/domain/repositories/product_repository.dart';
import 'package:brik/features/product/domain/usecases/get_product.dart';
import 'package:brik/features/product/domain/usecases/get_products.dart';

import 'package:brik/features/product/presentation/provider/get_product_notifier.dart';
import 'package:brik/features/product/presentation/provider/get_products_notifier.dart';
import 'package:brik/features/product/data/datasources/product_remote_data_souce.dart';
import 'package:brik/features/product/presentation/provider/store_product_notifier.dart';

final locator = GetIt.instance;

void init() {
  // REMOTE DATA SOURCE 
  locator.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(client: locator()));

  // REPOSITORY 
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(remoteDataSource: locator()));

  // USE CASE
  locator.registerLazySingleton(() => GetProductsUseCase(locator()));
  locator.registerLazySingleton(() => GetProductUseCase(locator()));
  locator.registerLazySingleton(() => StoreProductUseCase(locator()));

  // NOTIFIER
  locator.registerFactory(() => GetProductsNotifier(getProductsUseCase: locator()));
  locator.registerFactory(() => GetProductNotifier(getProductUseCase: locator()));
  locator.registerFactory(() => StoreProductNotifier(storeProductUseCase: locator()));

  DioHelper dio = DioHelper();
  Dio getDio = dio.getClient();

  locator.registerLazySingleton(() => getDio);
}
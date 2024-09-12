import 'package:brik/features/product/data/models/product_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:brik/features/product/data/models/product.dart';

import 'package:brik/common/errors/exception.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts({
    required String search,
    required int skip,
    required int limit,
  });
  Future<ProductDetail> getProduct({required String id});
  Future<void> storeProduct({required String title});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  Dio client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Product>> getProducts({
    required String search,
    required int skip,
    required int limit,
  }) async {
    try { 
      final response = await client.get("/products/search?q=$search&limit=$limit&skip=$skip");
      Map<String, dynamic> data = response.data;
      ProductModel productModel = ProductModel.fromJson(data);
      List<Product> productData = productModel.products;
      return productData;
    } on DioException catch (e) {
      String message = handleDioException(e);
      throw ServerException(message);
    } catch (e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }

  @override 
  Future<ProductDetail> getProduct({required String id}) async {
    try {
      final response = await client.get("/products/$id");
      Map<String, dynamic> data = response.data;
      ProductDetail productDetailModel = ProductDetail.fromJson(data);
      return productDetailModel;
    } catch(e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }

  @override 
  Future<void> storeProduct({required String title}) async {
    try {
      await client.post("/products/add", 
        data: {
          "title": title
        }
      );
    } catch(e, stacktrace) {
      debugPrint(stacktrace.toString());
      throw Exception(e.toString());
    }
  }

}
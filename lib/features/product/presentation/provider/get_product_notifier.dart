import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:brik/features/product/domain/usecases/get_product.dart';

import 'package:brik/features/product/data/models/product_detail.dart';

import 'package:brik/common/helpers/enum.dart';

class GetProductNotifier with ChangeNotifier {
  final GetProductUseCase getProductUseCase;

  GetProductNotifier({
    required this.getProductUseCase
  });

  ProductDetail _product = ProductDetail();
  ProductDetail get product => _product;

  ProviderState _state = ProviderState.idle;
  ProviderState get state => _state;

  String _message = "";
  String get message => _message;

  void setStateProvider(ProviderState newState) {
    _state = newState;

    notifyListeners();
  }

  Future<void> getProduct({required String id}) async {
    setStateProvider(ProviderState.loading);

    final result = await getProductUseCase.execute(id: id);

    result.fold((l) {
      
      _message = l.message;
      setStateProvider(ProviderState.error);

    }, (r) {

      _product = r;
      setStateProvider(ProviderState.loaded);
    
    });
  }

}
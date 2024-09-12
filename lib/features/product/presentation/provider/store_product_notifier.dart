import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:brik/features/product/domain/usecases/store_product.dart';
import 'package:brik/common/helpers/enum.dart';

class StoreProductNotifier with ChangeNotifier {
  final StoreProductUseCase storeProductUseCase;

  StoreProductNotifier({
    required this.storeProductUseCase
  });

  ProviderState _state = ProviderState.idle;
  ProviderState get state => _state;

  String _message = "";
  String get message => _message;

  void setStateProvider(ProviderState newState) {
    _state = newState;

    notifyListeners();
  }

  Future<void> storeProduct({required String title}) async {
    setStateProvider(ProviderState.loading);

    final result = await storeProductUseCase.execute(title: title);

    result.fold((l) {
      
      _message = l.message;
      setStateProvider(ProviderState.error);

    }, (r) {

      setStateProvider(ProviderState.loaded);
    
    });
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:brik/features/product/data/models/product.dart';
import 'package:brik/features/product/domain/usecases/get_products.dart';

import 'package:brik/common/helpers/enum.dart';

class GetProductsNotifier with ChangeNotifier {
  final GetProductsUseCase getProductsUseCase;

  GetProductsNotifier({
    required this.getProductsUseCase
  });

  bool isLoading = false;
  int limit = 10; 
  int skip = 0;
  bool hasMoreData = true;

  List<Product> _products = [];
  List<Product> get products => [..._products];

  ProviderState _state = ProviderState.idle;
  ProviderState get state => _state;

  String _message = "";
  String get message => _message;

  void setStateProvider(ProviderState newState) {
    _state = newState;

    notifyListeners();
  }

  Future<void> getProducts({required String search}) async {
    setStateProvider(ProviderState.loading);

    final result = await getProductsUseCase.execute(
      search: search,
      skip: skip,
      limit: limit,
    );

    result.fold((l) {
      
      _message = l.message;
      setStateProvider(ProviderState.error);

    }, (r) {

      _products = [];
      _products.addAll(r);
      setStateProvider(ProviderState.loaded);

      if(products.isEmpty) {
        setStateProvider(ProviderState.empty);
      }
    
    });
  }

  Future<void> loadMore({required String search}) async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    notifyListeners();

    skip += limit;

    final result = await getProductsUseCase.execute(
      search: search,
      skip: skip,
      limit: limit,
    );


    result.fold((l) {
      
      _message = l.message;
      setStateProvider(ProviderState.error);

    }, (r) {

      _products.addAll(r);

      if (r.length < limit) {
        hasMoreData = false;
      }

      isLoading = false;

      setStateProvider(ProviderState.loaded);
    
    });
  } 

}
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:brik/features/product/presentation/provider/get_products_notifier.dart';
import 'package:brik/features/product/presentation/provider/get_product_notifier.dart';
import 'package:brik/features/product/presentation/provider/store_product_notifier.dart';

import 'package:brik/injection.dart' as di;

List<SingleChildWidget> providers = [
  ...independentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => di.locator<GetProductsNotifier>()),
  ChangeNotifierProvider(create: (_) => di.locator<GetProductNotifier>()),
  ChangeNotifierProvider(create: (_) => di.locator<StoreProductNotifier>()),
];
import 'dart:async';

import 'package:brik/common/helpers/enum.dart';

import 'package:brik/features/product/data/models/product.dart';
import 'package:brik/features/product/presentation/pages/add_product.dart';
import 'package:brik/features/product/presentation/pages/widget/product_item.dart';
import 'package:brik/features/product/presentation/provider/get_products_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  static const String route = '/products';

  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {

  late GetProductsNotifier getProductsNotifier;

  Timer? debounce;

  late TextEditingController searchC;
  late FocusNode searchFn;

  Future<void> getData() async {
    if(!mounted) return; 
      await getProductsNotifier.getProducts(search: "");
  }

  @override 
  void initState() {
    super.initState();

    getProductsNotifier = context.read<GetProductsNotifier>();

    searchC = TextEditingController();
    searchFn = FocusNode();

    searchC.addListener(() {

      if(searchC.text.isNotEmpty) {
        if (debounce?.isActive ?? false) debounce?.cancel();
          debounce = Timer(const Duration(milliseconds: 1000), () {
            getProductsNotifier.getProducts(search: searchC.text);
          });
      }

    });

    Future.microtask(() => getData());
  }

  @override 
  void dispose() {

    searchC.dispose();
    searchFn.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetProductsNotifier>(
        builder: (_, notifier, __) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!notifier.isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                notifier.loadMore(search: searchC.text);
              }
              return true;
            },
            child: RefreshIndicator.adaptive(
              onRefresh: () {
                return Future.sync(() {
                  getData();
                });
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
              
                  SliverAppBar(
                    elevation: 5.0,
                    backgroundColor: Colors.purple[200]!,
                    centerTitle: true,
                    forceElevated: false,
                    floating: true,
                    pinned: true,
                    snap: true,
                    title: const Text("Klontong",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60.0),
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        margin: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchC,
                                focusNode: searchFn,
                                style: const TextStyle(
                                  fontSize: 16.0
                                ),
                                decoration: InputDecoration(
                                  hintText: "Search by Title",
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 16.0,
                                    right: 16.0
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  )
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AddProductScreen.route);
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )
                          ],  
                        ) 
                      ),
                    )
                  ),
              
                  if(notifier.state == ProviderState.loading) 
                    const SliverFillRemaining(
                      hasScrollBody: true,
                      child: Center(
                        child: CircularProgressIndicator()
                      ),
                    ),
              
                  if(notifier.state == ProviderState.empty)
                    const SliverFillRemaining(
                      hasScrollBody: true,
                      child: Center(
                        child: Text("There is no Product")
                      ),
                    ),
              
                   if(notifier.state == ProviderState.error)
                    const SliverFillRemaining(
                      hasScrollBody: true,
                      child: Center(
                        child: Text("Oops! Please try again later")
                      ),
                    ),
              
                  if(notifier.state == ProviderState.loaded)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
              
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.0 / 2.3,
                              mainAxisSpacing: 10.0
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: notifier.products.length + (notifier.isLoading ? 1 : 0),
                            itemBuilder: (BuildContext context, int i) {
              
                              if (i == notifier.products.length && notifier.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
              
                              if (i < notifier.products.length) {
                                final Product product = notifier.products[i];
                                return ProductItem(product: product);
                              } else {
                                return const SizedBox(); 
                              }
                              
                            },  
                          ),
                          
                        ])
                      ),
                    )
              
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
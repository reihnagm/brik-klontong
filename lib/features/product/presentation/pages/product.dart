
import 'package:brik/common/helpers/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:brik/features/product/presentation/provider/get_product_notifier.dart';

import 'package:brik/common/helpers/enum.dart';

class ProductScreen extends StatefulWidget {
  final String id;
  const ProductScreen({
    required this.id,
    super.key
  });

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {

  late GetProductNotifier getProductNotifier;

  Future<void> getData() async {
    if(!mounted) return;
      getProductNotifier.getProduct(id: widget.id);
  }

  @override 
  void initState() {
    super.initState();

    getProductNotifier = context.read<GetProductNotifier>();
    
    Future.microtask(() => getData());
  }

  @override 
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          
          Consumer<GetProductNotifier>(
            builder: (__, notifier, _) {
              return RefreshIndicator(
                onRefresh: () {
                  return Future.sync(() {

                  });
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                        
                    SliverAppBar(
                      elevation: 0.0,
                      toolbarHeight: 70.0,
                      leadingWidth: 33.0,
                      pinned: true,
                      floating: false,
                      centerTitle: false,
                      titleSpacing: 0.0,
                      title: const SizedBox(),
                      leading: CupertinoNavigationBarBackButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                
                    if(notifier.state == ProviderState.loading) 
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                      ),

                    if(notifier.state == ProviderState.error) 
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text("Hmm... Mohon tunggu yaa",
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          )
                        )
                      ),

                    if(notifier.state == ProviderState.loaded) 
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20.0
                        ),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                          
                            SizedBox(
                              height: 450.0,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                        
                                  CachedNetworkImage(
                                    imageUrl: notifier.product.thumbnail.toString(),
                                    imageBuilder: (_, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fitWidth
                                          )
                                        ),
                                      );
                                    },
                                    placeholder: (_, __) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(Images.defaultImg),
                                            fit: BoxFit.fitWidth
                                          )
                                        ),
                                      ); 
                                    },
                                    errorWidget: (_, __, ___) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(Images.defaultImg),
                                            fit: BoxFit.fitWidth
                                          )
                                        ),
                                      ); 
                                    },
                                  ),
                          
                                ],
                              )
                            ),
                            
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0,
                                bottom: 5.0, top: 5.0
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                        
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(notifier.product.price.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16.0, 
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ),
                                  
                                  Text(notifier.product.title.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 16.0
                                    )
                                  ),
                        
                                  const SizedBox(height: 8.0),
                        
                                  Text("Min Order ${notifier.product.minimumOrderQuantity.toString()}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey
                                    )
                                  ),
                        
                                  const SizedBox(height: 8.0),
                                  
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                        
                                      const Text("Stock",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                        ),
                                      ),
                        
                                      const SizedBox(width: 8.0),
                        
                                      Text(notifier.product.stock.toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black
                                        ),
                                      )
                                      
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 6.0),
                                  
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                        
                                      const Text("Weight",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                        ),
                                      ),
                        
                                      const SizedBox(width: 8.0),
                        
                                      Text("${notifier.product.weight.toString()} gr",
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black
                                        ),
                                      )
                                      
                                    ],
                                  ),
                        
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                                          
                            const Divider(
                              thickness: 1.8,
                              color: Colors.grey,
                            ),
                            
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0,
                                bottom: 5.0, top: 5.0
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ReadMoreText(
                                    notifier.product.description.toString(),
                                    trimLength: 150,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                    ),
                                    delimiter: " ",
                                    trimExpandedText: "Close",
                                    trimCollapsedText: "Read More",
                                    moreStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                    lessStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                    delimiterStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                            ),
                            
                          ]
                        )
                                            ),
                      )
                  ],
                ),
              );
            },
          ),
    
        ],
      )
        
    
    );

  }
}
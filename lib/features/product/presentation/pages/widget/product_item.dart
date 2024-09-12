import 'package:brik/features/product/presentation/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:brik/common/helpers/image.dart';

import 'package:brik/features/product/data/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  
  const ProductItem({
    required this.product,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.80,
      color: const Color(0xffF1F1F1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          Navigator.pushNamed(
            context, 
            ProductScreen.route,
            arguments: {
              "id": product.id.toString()
            }
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(
              height: 120.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [

                  CachedNetworkImage(
                    imageUrl: product.thumbnail.toString(),
                    imageBuilder: (_, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)
                          ),
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
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)
                          ),
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
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)
                          ),
                          image: DecorationImage(
                            image: AssetImage(Images.defaultImg),
                            fit: BoxFit.fitWidth
                          )
                        ),
                      ); 
                    },
                  ),
            
                ],
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0, 
                right: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(product.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Text(product.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      )
    ); 
  }
}
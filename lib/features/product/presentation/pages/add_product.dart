import 'package:brik/common/helpers/enum.dart';
import 'package:brik/features/product/presentation/provider/store_product_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String route = '/add-product';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {

  late TextEditingController titleC;

  late StoreProductNotifier storeProductNotifier;

  @override 
  void initState() {
    titleC = TextEditingController();
    storeProductNotifier = context.read<StoreProductNotifier>();

    super.initState();
  }

  @override
  void dispose() {
    titleC.dispose();

    super.dispose();
  }

  Future<void> submit() async {
    await storeProductNotifier.storeProduct(title: titleC.text);
    if(!mounted) return;
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.0,
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 16.0,
          right: 16.0
        ),
        child: ElevatedButton(
          onPressed: context.watch<StoreProductNotifier>().state == ProviderState.loading  
          ? () {} 
          : () {
            submit();
          }, 
          child: context.watch<StoreProductNotifier>().state == ProviderState.loading 
          ? const Text("Loading...",
            style: TextStyle(
              fontSize: 12.0
            ),
          )
          : const Text("Submit",
            style: TextStyle(
              fontSize: 12.0
            ),
          )
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
        ),
        slivers: [

          SliverAppBar(
            title: const Text("Add Product",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            leading: CupertinoNavigationBarBackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
              left: 16.0,
              right: 16.0
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                TextField(
                  controller: titleC,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      )
                    )
                  ),
                )

              ])
            ),
          )

        ],
      )
    );
  }
}
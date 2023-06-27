import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/provider/product_provider.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/attributes_tab_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/general_tab_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/shipping_tab_screen.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          elevation: 0,
          bottom: TabBar(tabs: [
            Tab(child: Text("General")),
            Tab(child: Text("Shipping")),
            Tab(child: Text("Attributes")),
            Tab(child: Text("Images")),
          ]),
        ),
        body: TabBarView(children: [
          GeneralScreen(),
          ShippingScreen(),
          AttributesScreen(),
          ImagesScreen(),
        ]),
        
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            print(_productProvider.productData["productName"]);
            print(_productProvider.productData["productPrice"]);
            print(_productProvider.productData["productQuantity"]);
            print(_productProvider.productData["productCategory"]);
            print(_productProvider.productData["productDescription"]);
            print(_productProvider.productData["imageUrlList"]);
          }, child: Text("Save")),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store/provider/product_provider.dart';
import 'package:multi_store/vendor/views/screens/main_vendor_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/attributes_tab_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/general_tab_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_tab_screens/shipping_tab_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
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
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
                onPressed: () async {
                  EasyLoading.show(status: 'Uploading product');
                  if (_formKey.currentState!.validate()) {
                    final productId = Uuid().v4();
                    await _firestore.collection('products').doc(productId).set({
                      'productID': productId,
                      'productName':
                          _productProvider.productData['productName'],
                      'productPrice':
                          _productProvider.productData['productPrice'],
                      'productQuantity':
                          _productProvider.productData['productQuantity'],
                      'productCategory':
                          _productProvider.productData['productCategory'],
                      'productDescription':
                          _productProvider.productData['productDescription'],
                      'imageUrlList':
                          _productProvider.productData['imageUrlList'],
                      'sizeList': _productProvider.productData['sizeList'],
                      'chargeShipping':
                          _productProvider.productData['chargeShipping'],
                      'shippingCharge':
                          _productProvider.productData['shippingCharge'],
                      'brandName': _productProvider.productData['brandName'],
                      'scheduleDate':
                          _productProvider.productData['scheduleDate'],
                      'vendorID': FirebaseAuth.instance.currentUser!.uid,
                    }).whenComplete(() {
                      _productProvider.clearData();
                      EasyLoading.dismiss();
                      _formKey.currentState!.reset();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MainVendorScreen();
                      }));
                    });
                  }
                },
                child: Text("Save")),
          ),
        ),
      ),
    );
  }
}

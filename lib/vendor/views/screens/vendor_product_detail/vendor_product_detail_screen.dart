import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store/utils/show_snackBar.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productBrandController = TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _productPriceController.text =
          widget.productData['productPrice'].toString();
      _productQuantityController.text =
          widget.productData['productQuantity'].toString();
      _productDescriptionController.text =
          widget.productData['productDescription'];
      _productBrandController.text = widget.productData['brandName'];
      _productCategoryController.text = widget.productData['categoryName'];
    });
    super.initState();
  }

  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        title: Text(
          widget.productData['productName'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _productBrandController,
                decoration: InputDecoration(
                  labelText: 'Product Brand',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  productPrice = double.parse(value);
                },
                controller: _productPriceController,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  productQuantity = int.parse(value);
                },
                controller: _productQuantityController,
                decoration: InputDecoration(
                  labelText: 'Product Quantity',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 800,
                maxLines: 4,
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: false,
                controller: _productDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Product Category',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: 'Updating');
            if (productPrice != null && productQuantity != null) {
              await _firestore
                  .collection('products')
                  .doc(widget.productData['productId'])
                  .update({
                'productName': _productNameController.text,
                'brandName': _productBrandController.text,
                'productQuantity': productQuantity,
                'productPrice': productPrice,
                'productDescription': _productDescriptionController.text,
                'productCategory': _productCategoryController.text,
              }).whenComplete(() {
                EasyLoading.dismiss();

                Navigator.pop(context);
              });
            } else {
              showSnack(context, 'Update quantity and price at least!');
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

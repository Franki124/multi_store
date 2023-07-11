import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection("categories")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc["categoryName"]);
        });
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  String formatedDate(date) {
    final outPutDateFormat = DateFormat("dd/MM/yyyy");
    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: "Enter product name",
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product price';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _productProvider.getFormData(
                      productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: "Enter product price",
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product quantity';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _productProvider.getFormData(
                      productQuantity: int.parse(value));
                },
                decoration: InputDecoration(
                  labelText: "Enter product quantity",
                ),
              ),
              SizedBox(height: 30),
              DropdownButtonFormField(
                  hint: Text("Select product category"),
                  items: _categoryList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _productProvider.getFormData(productCategory: value);
                    });
                  }),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter product description';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(productDescription: value);
                },
                minLines: 3,
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: "Enter product description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(5000))
                          .then((value) {
                        setState(() {
                          _productProvider.getFormData(scheduleDate: value);
                        });
                      });
                    },
                    child: Text("Schedule")),
                if (_productProvider.productData['scheduleDate'] != null)
                  Text(formatedDate(
                      _productProvider.productData["scheduleDate"])),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

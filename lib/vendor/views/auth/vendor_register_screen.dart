import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/vendor_register_controller.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();

  late String businessName;
  late String email;
  late String phoneNumber;
  late String taxNumber;

  late String countryValue;
  late String stateValue;
  late String cityValue;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List image =
        await _vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  String? _taxStatus;

  List<String> _taxOptions = ["yes", "no"];

  _saveVendorDetail() async {
    EasyLoading.show(status: "Processing");
    if (_formKey.currentState!.validate()) {
      await _vendorController.registerVendor(businessName, email, phoneNumber,
          countryValue, stateValue, cityValue, _taxStatus!, taxNumber, _image).whenComplete(() {
        EasyLoading.dismiss();

        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      });
    } else {
      print("Validation error");
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue.shade900,
                    Colors.purple,
                  ])),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: _image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.memory(_image!))
                              : IconButton(
                                  onPressed: () {
                                    selectGalleryImage();
                                  },
                                  icon: Icon(CupertinoIcons.photo)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value){
                        businessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide business name";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Business name",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value){
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide email address";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email address",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value){
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please provide phone number";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone number",
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax registered?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Container(
                              width: 100,
                              child: DropdownButtonFormField(
                                  hint: Text("select"),
                                  items: _taxOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _taxStatus = value;
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_taxStatus == "yes")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value){
                            taxNumber = value;
                          },
                          decoration: InputDecoration(labelText: "Tax number"),
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        _saveVendorDetail();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 120,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

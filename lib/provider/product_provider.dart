import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  getFormData({
    String? productName,
    double? productPrice,
    int? productQuantity,
    String? productCategory,
    String? productDescription,
    DateTime? scheduleDate,
    List<String>? imageUrlList,
    bool? chargeShipping,
    int? shippingCharge,
  }) {
    if (productName != null) {
      productData["productName"] = productName;
    }
    if (productPrice != null) {
      productData["productPrice"] = productPrice;
    }
    if (productQuantity != null) {
      productData["productQuantity"] = productQuantity;
    }
    if (productCategory != null) {
      productData["productCategory"] = productCategory;
    }
    if (productDescription != null) {
      productData["productDescription"] = productDescription;
    }
    if (scheduleDate != null) {
      productData["scheduleDate"] = scheduleDate;
    }
    if (imageUrlList != null) {
      productData["imageUrlList"] = imageUrlList;
    }
    if (chargeShipping != null) {
      productData["chargeShipping"] = chargeShipping;
    }
    if (shippingCharge != null) {
      productData["shippingCharge"] = shippingCharge;
    }
  }
}

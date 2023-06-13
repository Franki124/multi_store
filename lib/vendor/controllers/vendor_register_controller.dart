import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child("storeImages").child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print("No image selected");
    }
  }

  Future<String> registerVendor(
      String businessName,
      String email,
      String phoneNumber,
      String countryValue,
      String stateValue,
      String cityValue,
      String taxRegistered,
      String taxNumber,
      Uint8List? image,
      ) async {
    String res = "Error";
    try {
        String storeImage = await _uploadVendorImageToStorage(image);

        await _firestore.collection("vendors").doc(_auth.currentUser!.uid).set({
          "businessName": businessName,
          "email": email,
          "phoneNumber": phoneNumber,
          "countryValue": countryValue,
          "stateValue": stateValue,
          "cityValue": cityValue,
          "taxRegistered": taxRegistered,
          "taxNumber": taxNumber,
          "storeImage": storeImage,
          "approved": false,
          "vendorId": _auth.currentUser!.uid,
        });
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password) async {
    String res = "Some error";

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        //Create the user

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);


        await _firestore.collection("buyers").doc(cred.user!.uid).set({
          "email": email,
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "buyerId": cred.user!.uid,
          "address": "",
        });
      } else {
        res = "Please fill the fields";
      }
    } catch (e) {

    }
    return res;
  }

  loginUsers(String email, String password) async {
    String res = "Some error";

    try {
      if(email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
      } else {
        res = "Please fill the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

}

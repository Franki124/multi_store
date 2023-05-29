import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        res = "Success";
      } else {
        res = "Please fill the fields";
      }
    } catch (e) {

    }
    return res;
  }

}

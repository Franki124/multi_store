import 'package:flutter/material.dart';
import 'package:multi_store/controllers/auth_controller.dart';
import 'package:multi_store/utils/show_snackBar.dart';
import 'package:multi_store/views/buyers/auth/register_screen.dart';
import 'package:multi_store/views/buyers/main_screen.dart';

import '../../../vendor/views/auth/vendor_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.loginUsers(email, password);
    if (_formKey.currentState!.validate()) {

      if (res == "Success") {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }));
      } else {
        return showSnack(context, res);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, "Please provide valid information");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Customer's Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide email address";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide password";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _loginUsers();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _isLoading ? CircularProgressIndicator(color: Colors.white): Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Need An Account?"),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return BuyerRegisterScreen();
                    }));
                  }, child: Text("Register"))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Trying to log in as a vendor?"),
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return VendorAuthScreen();
                    }));
                  }, child: Text("Vendor sign in"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

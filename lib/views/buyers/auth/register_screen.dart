import 'package:flutter/material.dart';
import 'package:multi_store/controllers/auth_controller.dart';
import 'package:multi_store/views/buyers/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;


  _signUpUser() async {
    if(_formKey.currentState!.validate()) {
      await _authController.signUpUsers(
          email, fullName, phoneNumber, password);
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Customer's Account",
                  style: TextStyle(fontSize: 20),
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.blue.shade900,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please provide email address";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {email = value;},
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty) {
                          return "Please provide full name";
                        } else {
                          return null;
                        }
                      },
                    onChanged: (value) {fullName = value;},
                    decoration: InputDecoration(
                      labelText: "Full Name",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please provide phone number";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {phoneNumber = value;},
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Please provide password";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {password = value;},
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have An Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

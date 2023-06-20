import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store/controllers/auth_controller.dart';
import 'package:multi_store/utils/show_snackBar.dart';
import 'package:multi_store/views/buyers/auth/login_screen.dart';

class BuyerRegisterScreen extends StatefulWidget {
  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();


  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  Uint8List? _image;

  bool _isLoading = false;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUsers(email, fullName, phoneNumber, password, _image)
          .whenComplete(() {
        _formKey.currentState!.reset();
        _isLoading = false;
      });
      return showSnack(context, "Congratulations, account has been created");
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, "Please provide data to all fields");
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
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
                Stack(
                  children: [
                    _image!= null ? CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.blue.shade900,
                      backgroundImage: MemoryImage(_image!),
                    ): CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.blue.shade900,
                      backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/2/2c/Default_pfp.svg'),
                    ),
                    Positioned(
                      right: 0,
                        top: 0,
                        child: IconButton(
                      onPressed: () {
                        selectGalleryImage();
                      },
                      icon: Icon(CupertinoIcons.plus, color: Colors.white),
                    ))
                  ],
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
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide full name";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide phone number";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                    ),
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
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
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

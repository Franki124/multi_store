import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatelessWidget {
  const MainVendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}

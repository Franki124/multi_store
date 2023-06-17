import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.blue.shade900,
              title: Text(
                "Profile",
                style: TextStyle(letterSpacing: 1.3),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.star),
                )
              ],
            ),
            body: Column(
              children: [
                SizedBox(height: 25),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue.shade900,
                    backgroundImage: NetworkImage(data["profileImage"]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data["fullName"],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data["email"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Divider(thickness: 1.5, color: Colors.grey),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings", style: TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Phone number", style: TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: Icon(Icons.add_shopping_cart),
                  title: Text("Cart", style: TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text("Orders", style: TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text("Log out",
                      style:
                          TextStyle(color: Colors.blue.shade900, fontSize: 20)),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

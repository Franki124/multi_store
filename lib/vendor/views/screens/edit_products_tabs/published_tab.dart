import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:multi_store/vendor/views/screens/vendor_product_detail/vendor_product_detail_screen.dart';

class PublishedTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('approved', isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final vendorProductData = snapshot.data!.docs[index];
                  return Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) async {
                              await _firestore
                                  .collection('products')
                                  .doc(vendorProductData['productId'])
                                  .update({'approved': false});
                            },
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            icon: Icons.remove,
                            label: 'Unpublish',
                          ),
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) async {
                              await _firestore
                                  .collection('products')
                                  .doc(vendorProductData['productId'])
                                  .delete();
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return VendorProductDetailScreen(productData: vendorProductData);
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                    vendorProductData['imageUrl'][0]),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendorProductData['productName'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$ ' +
                                        vendorProductData['productPrice']
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
          );
        },
      ),
    );
  }
}
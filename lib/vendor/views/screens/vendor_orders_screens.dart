import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VendorOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormat.format(date);

    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          'My orders:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade900,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Slidable(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: document['accepted'] == true
                            ? Icon(Icons.delivery_dining_outlined)
                            : Icon(Icons.access_time),
                      ),
                      title: document['accepted'] == true
                          ? Text(
                              'Accepted',
                              style: TextStyle(
                                color: Colors.green.shade900,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              'Not accepted',
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      trailing: Text(
                        'Amount ' + document['productPrice'].toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      subtitle: Text(
                        formatedDate(
                          document['orderDate'].toDate(),
                        ),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Order details',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('View order details'),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(document['productImage'][0]),
                          ),
                          title: Text(document['productName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Quantity: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    document['productQuantity'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              document['accepted'] == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Schedule delivery date: ',
                                        ),
                                        Text(
                                          formatedDate(
                                            document['scheduleDate'].toDate(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(''),
                              ListTile(
                                title: Text(
                                  'Customer details: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(document['fullName']),
                                    Text(document['email']),
                                    Text(document['phoneNumber']),
                                    Text(document['address']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(document['orderId'])
                            .update({
                          'accepted': false,
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.highlight_remove,
                      label: 'Reject',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(document['orderId'])
                            .update({
                          'accepted': true,
                        });
                      },
                      backgroundColor: Color(0xFF21CA29),
                      foregroundColor: Colors.white,
                      icon: Icons.check_circle_outline_outlined,
                      label: 'Accept',
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

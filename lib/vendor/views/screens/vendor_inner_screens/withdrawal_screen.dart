import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store/vendor/views/screens/earnings_screen.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatefulWidget {
  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  late String amount;

  late String name;

  late String mobile;

  late String bankName;

  late String bankAccountName;

  late String bankAccountNumber;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        title: Text(
          'Withdrawal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide amount';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount:',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    name = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name:',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide phone number';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    mobile = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile:',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide bank name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank name:',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide bank account name';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankAccountName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank account name:',
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide bank account number';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankAccountNumber = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank account number:',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final withdrawId = Uuid().v4();
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show(status: 'Withdrawing...');
                      await _firestore
                          .collection('withdraws')
                          .doc(withdrawId)
                          .set({
                        'amount': amount,
                        'name': name,
                        'mobile': mobile,
                        'bankName': bankName,
                        'bankAccountName': bankAccountName,
                        'bankAccountNumber': bankAccountNumber,
                      }).whenComplete(() {
                        EasyLoading.dismiss();
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return EarningsScreen();
                        }));
                      });
                    }
                  },
                  child: Text(
                    'Get cash',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

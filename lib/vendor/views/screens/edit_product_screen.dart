import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/vendor/views/screens/edit_products_tabs/published_tab.dart';
import 'package:multi_store/vendor/views/screens/edit_products_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue.shade900,
          title: Text(
            'Manage products',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 3
            ),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                'Published',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Tab(
              child: Text(
                'Unpublished',
                style: TextStyle(fontSize: 18),
              ),
            )
          ]),
        ),
        body: TabBarView(children: [
          PublishedTab(),
          UnpublishedTab(),
        ]),
      ),
    );
  }
}

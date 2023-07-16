import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  int _imageIndex = 0;

  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                      imageProvider: NetworkImage(
                          widget.productData['imageUrlList'][_imageIndex])),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['imageUrlList'].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue.shade900)),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                    widget.productData['imageUrlList'][index]),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '\$ ' + widget.productData['productPrice'].toStringAsFixed(2),
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Product description',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Text('View more',
                      style:
                          TextStyle(color: Colors.blue.shade900, fontSize: 20))
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.productData['productDescription'],
                      style:
                          TextStyle(color: Colors.grey.shade800, fontSize: 18),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('This product will be available from:',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Text(formatDate(widget.productData['scheduleDate'].toDate()),
                      style:
                          TextStyle(color: Colors.blue.shade900, fontSize: 20))
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Available  size: ',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedSize =
                                      widget.productData['sizeList'][index];
                                });
                              },
                              child:
                                  Text(widget.productData['sizeList'][index])),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart, color: Colors.white, size: 24),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add to cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

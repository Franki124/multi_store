import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _imageIndex = 0;
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
      body: Stack(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: PhotoView(
                imageProvider: NetworkImage(widget.productData['imageUrlList'][_imageIndex])),
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
                          border: Border.all(color: Colors.blue.shade900)
                        ),
                        height: 60,
                        width: 60,
                        child: Image.network(widget.productData['imageUrlList'][index]),
                      ),
                    ),
                  );
                }),
              ),
          ),
        ],
      ),
    );
  }
}

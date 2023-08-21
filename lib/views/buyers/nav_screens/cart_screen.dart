import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/provider/cart_provider.dart';
import 'package:multi_store/views/buyers/inner_screens/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: Text('Cart Screen',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItems();
            },
            icon: Icon(
              Icons.delete_forever_outlined,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _cartProvider.getCartItem.length,
          itemBuilder: (context, index) {
            final cartData = _cartProvider.getCartItem.values.toList()[index];
            return Card(
              child: SizedBox(
                height: 170,
                child: Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.network(cartData.imageUrl[0]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cartData.productName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('\$ ' + cartData.price.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade900)),
                          OutlinedButton(
                            onPressed: null,
                            child: Text(
                              cartData.productSize,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue.shade900,
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: cartData.quantity == 1
                                          ? null
                                          : () {
                                              _cartProvider
                                                  .decreament(cartData);
                                            },
                                      icon: Icon(
                                        CupertinoIcons.minus_circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      cartData.quantity.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: cartData.availableStock ==
                                              cartData.quantity
                                          ? null
                                          : () {
                                              _cartProvider
                                                  .increament(cartData);
                                            },
                                      icon: Icon(
                                        CupertinoIcons.plus_circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _cartProvider.removeItem(cartData.productId);
                                },
                                icon: Icon(
                                  Icons.remove_shopping_cart,
                                  size: 24,
                                  color: Colors.red.shade900,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Your Shopping Cart is empty",
      //         style: TextStyle(
      //             fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 5),
      //       ),
      //       SizedBox(height: 20),
      //       Container(
      //         height: 40,
      //         width: MediaQuery.of(context).size.width - 40,
      //         decoration: BoxDecoration(
      //           color: Colors.blue.shade900,
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Center(
      //           child: Text("Continue Shopping", style: TextStyle(fontSize: 18, color: Colors.white),),
      //         ),
      //       )
      //     ],
      //   ),
      // ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CheckoutScreen();
                  }));
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _cartProvider.totalPrice == 0.00 ? Colors.grey.shade700 : Colors.blue.shade900,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '\$ ' +
                    _cartProvider.totalPrice.toStringAsFixed(2) +
                    ' ' +
                    'Checkout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

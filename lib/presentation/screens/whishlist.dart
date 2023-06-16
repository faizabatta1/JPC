import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jpc/data/models/product.dart';

import 'product_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> _wishlistedProducts = [    {      'name': 'Product 1',      'price': '\$10.99',      'image': 'assets/images/product1.jpg',    },    {      'name': 'Product 2',      'price': '\$15.99',      'image': 'assets/images/product2.jpg',    },    {      'name': 'Product 3',      'price': '\$20.99',      'image': 'assets/images/product3.jpg',    },    {      'name': 'Product 4',      'price': '\$25.99',      'image': 'assets/images/product4.jpg',    },  ];

  List<Map<String, dynamic>> _cartProducts = [];

  void _addToCart(int index) {
    setState(() {
      _cartProducts.add(_wishlistedProducts[index]);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_wishlistedProducts[index]['name']} added to cart'),
      ),
    );
  }

  void _addAllToCart() {
    setState(() {
      _cartProducts.addAll(_wishlistedProducts);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All products added to cart'),
      ),
    );
  }

  void _deleteAll() {
    setState(() {
      _wishlistedProducts = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        centerTitle: true,
      ),
      body: _wishlistedProducts.isEmpty
          ? Center(
        child: Text('Your wishlist is empty'),
      )
          : Column(
        children: [
      Expanded(
      child: ListView.builder(
      itemCount: _wishlistedProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      product: Product.fromMap(_wishlistedProducts[index]),
                    ),
                  ),
                );
              },
              leading: SizedBox(
                height: 80.0,
                width: 80.0,
                child: Image.asset(
                  _wishlistedProducts[index]['image'],
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                _wishlistedProducts[index]['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(_wishlistedProducts[index]['price']),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => _addToCart(index),
              ),
            ),
          );
        },
      ),
    ),
    Container(
    padding: EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    ElevatedButton(
    onPressed: _addAllToCart,
    child: Text('Add All to Cart'),
    ),
    ElevatedButton(
    onPressed: _deleteAll,
    child: Text('Delete All'),
    style:              ElevatedButton.styleFrom(
      primary: Colors.red,
    ),
    ),
    ],
    ),
    ),
        ],
      ),
    );
  }
}
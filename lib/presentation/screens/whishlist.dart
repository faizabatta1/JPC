import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/data/models/product.dart';

import 'product_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> _wishlistedProducts = [
    {
      'name': 'Product 1',
      'price': '\$10.99',
      'image': 'assets/images/product1.jpg',
    },
    {
      'name': 'Product 2',
      'price': '\$15.99',
      'image': 'assets/images/product2.jpg',
    },
    {
      'name': 'Product 3',
      'price': '\$20.99',
      'image': 'assets/images/product3.jpg',
    },
    {
      'name': 'Product 4',
      'price': '\$25.99',
      'image': 'assets/images/product4.jpg',
    },
  ];

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
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        padding: EdgeInsets.all(16.0),
        itemCount: _wishlistedProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildWishlistItem(index);
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildWishlistItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                product: Product.fromJson(_wishlistedProducts[index]),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                child: CachedNetworkImage(
                  imageUrl: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  fit: BoxFit.cover,
                  width: double.infinity,

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                _wishlistedProducts[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(_wishlistedProducts[index]['price']),
            ),
            TextButton(
              onPressed: () => _addToCart(index),
              child: Text('Add to Cart', style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.all(16.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _addAllToCart,
            child: Text('Add All to Cart', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: ThemeHelper.primaryColor),

          ),
          ElevatedButton(
            onPressed: _deleteAll,
            child: Text('Delete All', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }
}

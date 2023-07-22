import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoriteProductsScreen extends StatefulWidget {
  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  List<Map<String, dynamic>> _products = [
    {
      'name': 'Wireless Earbuds',
      'image': 'assets/images/product1.jpg',
      'price': 49.99,
      'isFavorite': true,
    },
    {
      'name': 'Smart Watch',
      'image': 'assets/images/product2.jpg',
      'price': 149.99,
      'isFavorite': true,
    },
    {
      'name': 'Bluetooth Speaker',
      'image': 'assets/images/product3.jpg',
      'price': 99.99,
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigate to product detail screen
            },
            child: Padding(
              padding:
              const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget:
                            (context, url, error) =>
                            Icon(Icons.error),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            vertical: 10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${'name'}",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${'price'}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "(50 Reviews)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
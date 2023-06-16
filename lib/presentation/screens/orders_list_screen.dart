import 'package:flutter/material.dart';

import 'order_status_screen.dart';

class OrdersListScreen extends StatelessWidget {
  final List<Order> orders = [    Order('Order #1', 'Delivered', 'May 1, 2023', [      Product('iPhone 13', 'https://via.placeholder.com/150x150', 1, 999.99),      Product('AirPods Pro', 'https://via.placeholder.com/150x150', 2, 249.99),    ]),
    Order('Order #2', 'In transit', 'April 28, 2023', [
      Product('MacBook Pro', 'https://via.placeholder.com/150x150', 1, 1999.99),
    ]),
    Order('Order #3', 'Delivered', 'April 25, 2023', [
      Product('Apple Watch Series 7', 'https://via.placeholder.com/150x150', 1, 399.99),
      Product('iPad Air', 'https://via.placeholder.com/150x150', 1, 599.99),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Your Orders'),
    ),
    body: ListView.builder(
    itemCount: orders.length,
    itemBuilder: (BuildContext context, int index) {
    final order = orders[index];
    return InkWell(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => OrderStatusScreen(order),
    ),
    );
    },
    child: Card(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    order.title,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    ),
    ),
    Text(
    order.deliveryStatus,
    style: TextStyle(
    color: order.deliveryStatus == 'Delivered' ? Colors.green : Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    ),
    ),
    ],
    ),
    SizedBox(height: 8.0),
    Text(
    'Ordered on ${order.orderDate}',
    style: TextStyle(
    color: Colors.grey[600],
    fontSize: 14.0,
    ),
    ),
    SizedBox(height: 16.0),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: order.products.map((product) {
    return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Image.network(
    product.imageUrl,
    height: 80.0,
    ),
    SizedBox(width: 16.0),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    product.title,
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    ),
    ),
    SizedBox(height: 8.0),
    Text(
    '${product.quantity} x \$${product.price}',
    style: TextStyle(
    color: Colors.grey[600],
    fontSize: 12.0,
    ),
    ),
    SizedBox(height: 8.0),
    Text(
    'Total: \$${product.total}',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    ),
    ),                            ],
    ),
    ),
    ],
    );
    }).toList(),
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

class Order {
  final String title;
  final String deliveryStatus;
  final String orderDate;
  final List<Product> products;

  Order(this.title, this.deliveryStatus, this.orderDate, this.products);
}

class Product {
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;
  final double total;

  Product(this.title, this.imageUrl, this.quantity, this.price) : total = quantity * price;
}
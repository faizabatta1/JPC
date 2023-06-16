import 'product.dart';

class Order {
  final int id;
  final String orderNumber;
  final List<Product> products;
  final double total;
  final String deliveryStatus;

  Order({
    required this.id,
    required this.orderNumber,
    required this.products,
    required this.total,
    required this.deliveryStatus,
  });
}
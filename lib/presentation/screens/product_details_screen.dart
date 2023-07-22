import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/data/models/cart_item.dart';
import 'package:jpc/data/models/product.dart';
import 'package:jpc/presentation/blocs/product_details_bloc/product_details_bloc.dart';

import '../../core/helpers/theme_helper.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key,required this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorited = false;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: ThemeHelper.primaryColor,
      ),
      body: BlocConsumer<ProductDetailsBloc,ProductDetailsState>(
        listener: (context,state){
          if(state is ProductAddToCartSuccess){
            showSnackbar(context: context, message: state.message);
          }else if(state is ProductAddToCartFailed){
            showSnackbar(context: context, message: state.message);
          }
        }, builder: (context,state){
          if(state is ProductLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              _isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: _isFavorited ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isFavorited = !_isFavorited;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20, color: ThemeHelper.secondaryColor),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.product.hasDiscount ? '${widget.product.discount.toInt()}% OFF' : '',
                        style:
                        TextStyle(fontSize: 20, color: ThemeHelper.accentColor),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Quantity:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _quantity--;
                                if (_quantity < 1) {
                                  _quantity = 1;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: ThemeHelper.secondaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.remove,
                                  color: ThemeHelper.secondaryColor),
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: ThemeHelper.secondaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                _quantity.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: ThemeHelper.secondaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.add,
                                  color: ThemeHelper.secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
      },
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${(widget.product.price * _quantity).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                CartItem cartItem = CartItem(
                    product: widget.product,
                    quantity: _quantity
                );

                context.read<ProductDetailsBloc>().add(
                  AddToCartEvent(cartItem: cartItem)
                );
              },
              child: Text('Add to cart'),
              style: ElevatedButton.styleFrom(
                primary: ThemeHelper.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

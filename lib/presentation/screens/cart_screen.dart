import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jpc/core/error_handling/decrease_cart_item_error.dart';
import 'package:jpc/core/helpers/payment_helper.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/data/models/cart_item.dart';
import 'package:jpc/presentation/blocs/auth_status/auth_status_bloc.dart';
import 'package:jpc/presentation/screens/payment_screen.dart';

import '../../data/models/product.dart';
import '../blocs/cart_bloc/cart_bloc.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartBloc>().add(LoadCartItems(uid: FirebaseAuth.instance.currentUser!.uid));
  }

  double _countTotal(List<CartItem> cartItems){
    double total = 0;
    for (var i = 0; i < cartItems.length; i++) {
      CartItem cartItem = cartItems[i];
      total += cartItem.product.price * cartItem.quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){

              },
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: BlocConsumer<CartBloc,CartState>(
        listener: (context,state){
          if(state is CartDecreaseItemError){
            showSnackbar(context: context, message: state.message);
          }
        },
        builder: (context,state){
          if(state is CartLoadSuccess){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index){
                        CartItem cartItem = state.cartItems[index];
                        Product product = cartItem.product;

                        return _CartItem(
                            cartItem: cartItem,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${formatter.format(_countTotal(state.cartItems))}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async{

                    },
                    child: Text('Complete Purchase'),
                    style: ThemeHelper.fullSizePrimaryButtonStyle(context),
                  ),
                ],
              ),
            );
          }else if(state is CartLoadFail){
            return Center(
              child: AutoSizeText(state.message,maxLines: 1,),
            );
          }else if(state is CartLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is CartIsEmpty){
            return Center(
              child: Text(state.message),
            );
          }else{
            return Center(
              child: Text('not implemeneted'),
            );
          }
        },
      ),
    );
  }
}

class _CartItem extends StatefulWidget {
  final CartItem cartItem;
  _CartItem({required this.cartItem});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<_CartItem> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            widget.cartItem.product.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartItem.product.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${widget.cartItem.product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Quantity: '),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            context.read<CartBloc>().add(
                                DecreaseQuantityEvent(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    productId: widget.cartItem.product.id
                                )
                            );

                            setState(() {
                              _quantity = _quantity - 1;
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(_quantity.toString()),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async{
                          context.read<CartBloc>().add(
                            IncreaseQuantityEvent(
                              productId: widget.cartItem.product.id,
                              uid: FirebaseAuth.instance.currentUser!.uid
                            )
                          );

                          setState(() {
                            _quantity = _quantity + 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:http/http.dart' as http;

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
    context.read<CartBloc>().add(LoadCartItems(uid: 'FirebaseAuth.instance.currentUser!.uid'));
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
        title: Text('Shopping Cart'),
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
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back),
                      Icon(Icons.add),
                    ],
                  ),
                  SizedBox(height: 24,),
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
                      await _completePayment(amount: _countTotal(state.cartItems));

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
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,size: 200,color: Colors.black12,),
                  Text(state.message,style: TextStyle(
                    fontSize: 26,
                    color: Colors.black26
                  ),)
                ],
              ),
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

  Future<void> _completePayment({required double amount}) async{
    try{
      final uri = Uri.parse('http://10.0.2.2:3000/create-payment-intent');
      final response = await http.post(uri,headers: {
        'Content-Type':'application/json; charset=utf-8'
      },body: jsonEncode({ 'amount': amount}));
      Map<String,dynamic> data = jsonDecode(response.body);
      print(data['clientSecret']);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: data['clientSecret'],
            applePay: PaymentSheetApplePay(
              merchantCountryCode: 'EG',

            ),
            googlePay: PaymentSheetGooglePay(
                merchantCountryCode: 'EG'
            ),
            style: ThemeMode.dark,
            merchantDisplayName: 'jpc_test_merchant',

          )
      );

      try{
        await Stripe.instance.presentPaymentSheet();
      }catch(err){

      }
    }catch(error){
      print(error.toString());
    }
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
      decoration: BoxDecoration(
        boxShadow: [

        ],
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.black12
      ),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            width: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.cartItem.product.imageUrl,
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cartItem.product.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.close,size: 24,color: Colors.black,),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${widget.cartItem.product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            context.read<CartBloc>().add(
                                DecreaseQuantityEvent(
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
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/data/models/cart_item.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final double paymentAmount;
  final List<CartItem> cartItems;

  const PaymentScreen({Key? key,required this.paymentAmount, required this.cartItems}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late TextEditingController _cardNumberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;
  late TextEditingController _cardHolderNameController;

  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  String _cardHolderName = '';
  bool _isCvvFocused = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _cardNumberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
    _cardHolderNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '\$${formatter.format(widget.paymentAmount)}',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        leading: CachedNetworkImage(
                            imageUrl: widget.cartItems[index].product.imageUrl,
                          errorWidget:(context,url,error){
                              return Text('broken');
                          },
                        ),
                        title: Text(widget.cartItems[index].product.name),
                        subtitle: Text(widget.cartItems[index].product.price.toString()),
                        trailing: Text(widget.cartItems[index].quantity.toString()),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Payment Method:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CreditCardWidget(
                    cardNumber: _cardNumber,
                    expiryDate: _expiryDate,
                    cardHolderName: _cardHolderName,
                    cvvCode: _cvv,
                    showBackView: _isCvvFocused,
                    height: 200.0,
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    cardBgColor: Colors.blueAccent,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    onCreditCardWidgetChange: (CreditCardBrand) {},
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter expiry date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            hintText: 'XXX',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          focusNode: FocusNode(canRequestFocus: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _cardHolderNameController,
                    decoration: InputDecoration(
                      labelText: 'Card Holder Name',
                      hintText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter card holder name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                        }
                      },
                      style: ThemeHelper.fullSizePrimaryButtonStyle(context),
                      child: Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

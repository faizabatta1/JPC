import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  static const String route = '/faq';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            FaqTile(
              question: 'What payment methods do you accept?',
              answer:
              'We accept all major credit cards (Visa, Mastercard, American Express), as well as PayPal and Apple Pay.',
            ),
            Divider(),
            FaqTile(
              question: 'What is your return policy?',
              answer:
              'If you are not satisfied with your purchase, you can return it within 30 days for a full refund. Please contact us for further instructions.',
            ),
            Divider(),
            FaqTile(
              question: 'How long does shipping take?',
              answer:
              'Shipping times vary depending on your location and the product you ordered. Generally, orders are processed within 1-2 business days and shipped within 5-7 business days.',
            ),
            Divider(),
            FaqTile(
              question: 'Do you offer international shipping?',
              answer:
              'Yes, we offer international shipping to most countries. Shipping rates and times may vary depending on your location.',
            ),
            Divider(),
            FaqTile(
              question: 'How can I track my order?',
              answer:
              'Once your order has been shipped, you will receive a tracking number via email. You can use this number to track your order on our website or the shipping carrier\'s website.',
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FaqTile extends StatefulWidget {
  final String question;
  final String answer;

  const FaqTile({required this.question, required this.answer});

  @override
  _FaqTileState createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.question,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 30,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: Text(
              widget.answer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            duration: const Duration(milliseconds: 200),
            crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
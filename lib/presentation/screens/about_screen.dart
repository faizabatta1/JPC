import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String route = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Image.asset('assets/jpc.png',height: 180,width: 180,),
          SizedBox(height: 30),
          Text(
            'My Shopping App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'My Shopping App is a great place to shop for all your needs. We offer a wide range of products at affordable prices. Whether you are looking for clothing, electronics, home decor, or anything else, we have it all!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.mail_outline),
                onPressed: () {
                  // Handle mail button pressed
                },
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {
                  // Handle phone button pressed
                },
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.web),
                onPressed: () {
                  // Handle website button pressed
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
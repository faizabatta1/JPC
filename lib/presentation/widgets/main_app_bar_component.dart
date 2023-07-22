import 'package:flutter/material.dart';
import 'package:jpc/presentation/screens/cart_screen.dart';
import 'package:jpc/presentation/screens/notifications_screen.dart';

class MainAppbarComponent extends StatelessWidget {
  const MainAppbarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CartScreen())
            );
          },
          child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 30,),
        ),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotificationsScreen())
            );
          },
          child: Icon(Icons.notifications_none_outlined,color: Colors.white,size: 30,),
        ),
      ],
    );
  }
}

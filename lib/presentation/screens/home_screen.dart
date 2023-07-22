import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/screens/favorite_products_screen.dart';
import 'package:jpc/presentation/screens/main_screen.dart';
import 'package:jpc/presentation/screens/more_screen.dart';
import 'package:jpc/presentation/screens/orders_list_screen.dart';
import 'package:jpc/presentation/screens/products_screen.dart';
import 'package:jpc/presentation/screens/profile_screen.dart';
import 'package:jpc/presentation/screens/rewards_screen.dart';
import 'package:jpc/presentation/screens/whishlist.dart';
import 'cart_screen.dart';
import 'payment_screen.dart';
import 'points_screen.dart';
import '../widgets/drawer_screen.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String,dynamic>> items = [
    { 'name': 'More', 'icon-outlined': Icons.article_outlined,'icon': Icons.article },
    { 'name': 'Favorites', 'icon-outlined': Icons.favorite_outline, 'icon': Icons.favorite },
    { 'name': 'Products', 'icon-outlined': Icons.shopping_bag_outlined, 'icon': Icons.shopping_bag },
    { 'name': 'Profile', 'icon-outlined': Icons.account_circle_outlined, 'icon': Icons.account_circle },
  ];

  List<Widget> screens = [
    MoreScreen(),
    FavoriteProductsScreen(),
    ProductsScreen(),
    ProfileScreen(),
    MainScreen()
  ];

  int _activeIndex = 4;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_activeIndex == index ? items[index]['icon'] : items[index]['icon-outlined'],color: _activeIndex == index ? ThemeHelper.secondaryColor : null,),
              Text(items[index]['name'])
            ],
          );
        },
        notchSmoothness: NotchSmoothness.smoothEdge,
        gapLocation: GapLocation.center,
        activeIndex: _activeIndex,
        onTap: (int index ) {
          setState(() {
            _activeIndex = index;
          });
        },

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _activeIndex = 4;
          });
        },
        child: Icon(Icons.home_outlined,size: 40,color: Colors.white,),
      ),

      body: screens[_activeIndex],
    );
  }
}


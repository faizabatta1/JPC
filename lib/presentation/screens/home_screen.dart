import 'package:flutter/material.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/screens/favorite_products_screen.dart';
import 'package:jpc/presentation/screens/orders_list_screen.dart';
import 'package:jpc/presentation/screens/products_screen.dart';
import 'package:jpc/presentation/screens/rewards_screen.dart';
import 'package:jpc/presentation/screens/whishlist.dart';
import 'cart_screen.dart';
import 'payment_screen.dart';
import 'points_screen.dart';
import '../widgets/drawer_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerScreen(),
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الصفحة الرئيسية',
            textDirection: TextDirection.rtl,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 15,),
            // Image at the top
            SizedBox(
              height: 150,
              child: Image.asset("assets/jpc.png", width: 150, height: 150,),
            ),

            // List of rectangles
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 5 / 3
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeHelper.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('المنتجات',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PointsScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeHelper.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('الرصيد',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrdersListScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeHelper.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('الطلبات',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RewardsScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeHelper.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('مكافئات',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishlistScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeHelper.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('wish list',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeHelper.secondaryColor,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('عربة التسوق',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteProductsScreen()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeHelper.secondaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Text('المفضلة',style: TextStyle(fontSize: 30,color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


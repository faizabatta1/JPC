import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:jpc/presentation/blocs/auth_status/auth_status_bloc.dart';
import 'package:jpc/presentation/screens/about_screen.dart';
import 'package:jpc/presentation/screens/orders_list_screen.dart';
import 'package:jpc/presentation/screens/products_screen.dart';
import 'package:jpc/presentation/screens/scan_qr_code_screen.dart';
import 'package:jpc/presentation/screens/terms_and_conditions.dart';
import 'package:jpc/presentation/screens/whishlist.dart';

import '../../core/helpers/theme_helper.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: ThemeHelper.primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Wallet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Implement wallet details screen navigation here
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "\$1,234.56",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Available Points: 500",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(
                    iconData: FontAwesomeIcons.qrcode,
                    text: 'Scan Qr Code',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return QrCodeScanner();
                      }));
                    },
                  ),
                  buildMenuItem(
                    iconData: FontAwesomeIcons.shieldHalved,
                    text: 'Conditions & Terms',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return TermsAndConditionsScreen();
                      }));
                    },
                  ),
                  buildMenuItem(
                    iconData: FontAwesomeIcons.info,
                    text: 'About JPC',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AboutScreen();
                      }));
                    },
                  ),
                  buildMenuItem(
                    iconData: FontAwesomeIcons.solidStar,
                    text: 'Wish List',
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WishlistScreen()),
                      );
                    },
                  ),
                  buildMenuItem(
                    iconData: FontAwesomeIcons.boxesPacking,
                    text: 'Orders',
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => OrdersListScreen()),
                      );
                    },
                  ),
                  buildMenuItem(
                    iconData: FontAwesomeIcons.arrowRightFromBracket,
                    text: 'Logout',
                    onTap: () {
                      context.read<AuthStatusBloc>().add(
                        SignOutEvent()
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({required IconData iconData, required String text, required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          size: 32,
          color: ThemeHelper.primaryColor,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ThemeHelper.primaryColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: ThemeHelper.primaryColor,
        ),
        onTap: onTap,
      ),
    );
  }
}

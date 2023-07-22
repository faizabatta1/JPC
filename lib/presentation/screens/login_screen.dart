import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/screens/register_screen.dart';
import 'package:jpc/presentation/screens/reset_password.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "JPC Shop",
                style: GoogleFonts.akayaKanadaka(
                  fontSize: 30,
                  color: ThemeHelper.accentColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Login to your Account",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 30, top: 30),
              elevation: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: 320,
                height: 50,
                color: Colors.white,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.only(left: 30, top: 30),
              elevation: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: 320,
                height: 50,
                color: Colors.white,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 24.0,),
            Center(
              child: Container(
                width: 180,
                height: 40,
                child: MaterialButton(
                  elevation: 5,
                  // minWidth: 300,
                  color: ThemeHelper.accentColor,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    final UserAuthCredentials userAuthCredentials = UserAuthCredentials(
                        email: _emailController.text,
                        password: _passwordController.text
                    );

                    context.read<LoginBloc>().add(
                      LoginButtonPressed(userAuthCredentials: userAuthCredentials)
                    );
                  },
                  child: Text(
                    "sign in",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "- Or Sign in with -",
                style:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                onPressed: (){},
                icon: Icon(FontAwesomeIcons.google),
                label: Text("Google",
                  style: TextStyle(fontSize: 20),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an Account ? ",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.register);
                  },
                  child: Text(
                    "SignUp ",
                    style: TextStyle(
                        color: ThemeHelper.accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
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
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Login to your Account",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value != null){
                    if(value.isEmpty){
                      return "Please enter something";
                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                      return "This is not an email";
                    }

                    return null;
                  }

                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                controller: _passwordController,
                validator: (value){
                  if(value != null){
                    if(value.isEmpty){
                      return "Please enter password";
                    }

                    return null;
                  }

                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder()),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: Text('Forget password',style: TextStyle(
                  fontSize: 16,
                  color: ThemeHelper.accentColor
                ),),
              ),
            ),
            SizedBox(height: 0.0,),
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
                    if(_formKey.currentState != null){
                      if(_formKey.currentState!.validate()){
                        final UserAuthCredentials userAuthCredentials = UserAuthCredentials(
                            email: _emailController.text,
                            password: _passwordController.text
                        );

                        context.read<LoginBloc>().add(
                            LoginButtonPressed(userAuthCredentials: userAuthCredentials)
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Correct Data'))
                        );
                      }
                    }
                  },
                  child: Text(
                    "sign in",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an Account  ",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.register);
                  },
                  child: Text(
                    "SignUp ",
                    style: TextStyle(
                        color: ThemeHelper.accentColor,
                        fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: (){},
                child: Text('Are you a provider',style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey
                ),),
              ),
            ),
            SizedBox(height: 12.0,)
          ],
        ),
      ),
    );
  }
}

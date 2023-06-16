import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/screens/register_screen.dart';
import 'package:jpc/presentation/screens/reset_password.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/jpc.png",width: 170,height: 170,),
                const Text('تسجيل الدخول',style: TextStyle(
                    fontSize: 30
                )),
                const SizedBox(height: 30,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: ()async{

                          // var intent = PaymentIntent(id: '',status: '', amount: null, created: '', currency: '', clientSecret: '', livemode: true, captureMethod: CaptureMethod.Manual, confirmationMethod: null,);
                          // intent.amount = widget.order.cart.total;
                          // intent.isManual = true;
                          // intent.isConfirmed = false;
                          // intent.paymentMethodId = paymentResponse.paymentMethodId;
                          // intent.currency = "usd";
                          // intent.isOnSession = true;
                          // intent.isSuccessful = false;
                          // intent.statementDescriptor = "Dorm Mom, Inc";
                          // var response = await widget.clientDataStore.createPaymentIntent(intent);
                          //
                          //
                          // var intentResponse = await _stripePayment!.confirmPaymentIntent(
                          //     response.clientSecret, paymentResponse.paymentMethodId, widget.order.cart.total);
                          //
                          // if (intentResponse.status == PaymentResponseStatus.succeeded) {
                          //   widget.order.paymentIntentId = intentResponse.paymentIntentId;
                          //   widget.order.paymentMethodId = paymentResponse.paymentMethodId;
                          //   _submitOrder();
                          // } else if (intentResponse.status == PaymentResponseStatus.failed) {
                          //   setState(() {
                          //     hideBusy();
                          //   });
                          //   globals.Utility.showAlertPopup(
                          //       context, "Error Occurred", intentResponse.errorMessage);
                          // } else {
                          //   setState(() {
                          //     hideBusy();
                          //   });
                          // }
                        },
                        child: Text('test payment'),
                      ),
                      TextFormField(

                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value!.isEmpty){
                            return "please enter username";
                          }else if(value.length < 8){
                            return "username is too short";
                          }

                          return null;
                        },

                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Colors.black,),
                            border: OutlineInputBorder(

                            ),
                            label: Text('email'),
                            hintText: 'email',
                            suffixText: '@gmail.com'
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value!.isEmpty){
                            return "please enter a password";
                          }else if(value.length < 8){
                            return "your password is too short";
                          }

                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password,color: Colors.black,),
                            border: const OutlineInputBorder(),
                            label: const Text('password'),
                            hintText: 'password',
                            suffix: InkWell(
                              onTap: (){
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: _isPasswordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                            )
                        ),
                        obscureText: !_isPasswordVisible,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: const AutoSizeText('اعادة التعيين'),
                                  onPressed: (){
                                    Navigator.pushNamed(context, ResetPasswordScreen.reset);
                                  },
                                ),
                                const Text('هل نسيت الرقم السري ؟'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: const AutoSizeText('انشاء حساب'),
                                  onPressed: (){
                                    Navigator.pushNamed(context, RegisterScreen.register);
                                  },
                                ),
                                const Text('ليس لديك حساب ؟'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ThemeHelper.fullSizePrimaryButtonStyle(context),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              UserAuthCredentials userAuthCredentials = UserAuthCredentials(
                                  email: _emailController.text,
                                  password: _passwordController.text
                              );

                              context.read<LoginBloc>().add(
                                  LoginButtonPressed(
                                      userAuthCredentials: userAuthCredentials
                                  )
                              );
                            }
                          },
                          child: const AutoSizeText('تسجيل الدخول', style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Staatliches-Regular',
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          )
                      ),

                    ],

                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

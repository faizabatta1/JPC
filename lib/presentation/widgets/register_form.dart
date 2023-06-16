import 'package:flutter/material.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/models/user_information.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:jpc/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/cloud_messaging.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  bool _isPasswordVisible = false;

  @override
  void initState() {
    addressController.text = 'فلسطين';
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/jpc.png",
              width: 100,
              height: 100,
            ),
            const AutoSizeText(
              "انشاء حساب جديد",
              style: TextStyle(fontSize: 30),
              maxLines: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('الاسم الاول'),
                        hintText: 'الاسم الاول',
                        prefixIcon: Icon(Icons.text_fields),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('الاسم الاخير'),
                        hintText: 'الاسم الاخير',
                        prefixIcon: Icon(Icons.text_fields),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter an email address';
                    //   } else if (!gmailRegex.hasMatch(value)) {
                    //     return 'Please enter a valid Gmail address';
                    //   }
                    //   return null;
                    // },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('email'),
                      hintText: 'email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    validator: (password) {
                      if (password != null) {
                        if (password.isEmpty) {
                          return "please enter password";
                        } else if (password.length < 8) {
                          return "your password is very short";
                        }
                      } else {
                        return "please enter something";
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text('password'),
                        hintText: 'password',
                        prefixIcon: const Icon(Icons.password),
                        suffix: InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (confirm) {
                      if (confirm != null) {
                        if (confirm != passwordController.text) {
                          return "passwords are not identical";
                        } else if (confirm.isEmpty) {
                          return "please enter password";
                        } else if (confirm.length < 8) {
                          return "your password is very short";
                        }
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        border: const OutlineInputBorder(),
                        label: const Text('confirm password'),
                        hintText: 'confirm password',
                        suffix: InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                  const SizedBox(height: 20),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: IntlPhoneField(
                      initialCountryCode: 'PS',
                      controller: phoneController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          label: Text('رقم الهاتف'),
                          hintText: 'رقم الهاتف'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDecorator(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CountryCodePicker(
                          initialSelection: 'PS',
                          favorite: const ['+970', 'PS'],
                          showOnlyCountryWhenClosed: true,
                          showCountryOnly: true,
                          onChanged: (countryCode) {
                            addressController.text = countryCode.name!;
                          },
                        ),
                        const Text('اختر المدينة التابعة لك')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            UserAuthCredentials userAuthCredentials =
                                UserAuthCredentials(
                                    email: emailController.text,
                                    password: passwordController.text);

                            String? deviceToken =
                                await CloudMessaging.getToken();

                            UserInformation userInformation =
                                UserInformation(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    email: emailController.text,
                                    deviceToken: deviceToken!);

                            BlocProvider.of<RegisterBloc>(context).add(
                              RegisterButtonPressed(
                                  userInformation: userInformation,
                                  userAuthCredentials: userAuthCredentials
                              )
                            );
                          }
                        }
                      },
                      style: ThemeHelper.fullSizePrimaryButtonStyle(context),
                      child: const Text(
                        'انشاء',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Staatliches-Regular',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

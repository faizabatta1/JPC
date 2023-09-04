import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/data/entities/user_auth_credentials.dart';
import 'package:jpc/data/models/user_information.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:jpc/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MerchantRegisterForm extends StatefulWidget {
  const MerchantRegisterForm({Key? key}) : super(key: key);

  @override
  State<MerchantRegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<MerchantRegisterForm> {
  final TextEditingController usernameController = TextEditingController();
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Join JPC Shop",
              style: GoogleFonts.akayaKanadaka(
                fontSize: 30,
                color: ThemeHelper.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Create your Merchant Account",
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
                controller: usernameController,
                decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none),
              ),
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
                controller: emailController,
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
          Card(
            margin: EdgeInsets.only(left: 30, top: 30),
            elevation: 3,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 320,
              // Adjust the height of the Card to accommodate the IntlPhoneField
              height: 70,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // Wrap the IntlPhoneField with an Expanded widget
                child: Row(
                  children: [
                    Expanded(
                      // Use Expanded to make the IntlPhoneField take available width
                      child: IntlPhoneField(
                        controller: phoneController,
                        pickerDialogStyle: PickerDialogStyle(
                            searchFieldInputDecoration:InputDecoration(

                            )
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'PhoneNumber',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                        initialCountryCode: 'PS', // Replace with your desired initial country code
                        onChanged: (phone) {
                          // Use the onChanged callback to get the formatted phone number
                          print(phone.completeNumber);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(left: 30, top: 30),
            elevation: 3,
            child: Container(
              width: 330,
              height: 50,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CountryCodePicker(
                      onChanged: (country) {
                        addressController.text = country.name ?? '';
                      },
                      // Optional: Set the initial country code
                      initialSelection: 'PS',
                      favorite: ['PS', 'US'], // Optional: Add favorite country codes
                      showFlagMain: true,
                      showFlagDialog: true,
                    ),
                  ),
                  Expanded(
                    // Add an empty container to fill the remaining space
                    child: Container(),
                  ),
                ],
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
                controller: passwordController,
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
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 180,
              height: 40,
              child: MaterialButton(
                elevation: 5,
                // minWidth: 320,
                color: ThemeHelper.primaryColor,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async{

                  UserInformation userInformation = UserInformation(
                      username: usernameController.text,
                      phone: phoneController.text,
                      location: addressController.text,
                      email: emailController.text,
                      password: passwordController.text
                  );

                  context.read<RegisterBloc>().add(
                      RegisterButtonPressed(
                        userInformation: userInformation,
                      )
                  );
                },
                child: Text(
                  "sign up ",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

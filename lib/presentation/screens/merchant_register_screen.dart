import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:jpc/presentation/wrappers/auth_status_wrapper.dart';

import '../blocs/merchant_register_bloc/merchant_register_bloc.dart';
import '../widgets/merchant_register_form.dart';
import '../widgets/register_form.dart';

class MerchantRegisterScreen extends StatefulWidget {
  static const String register = '/register';
  const MerchantRegisterScreen({super.key});

  @override
  State<MerchantRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<MerchantRegisterScreen> {




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MerchantRegisterBloc()..add(MerchantResetRegisterInitial()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,size: 30,),
          ),
        ),
        body: BlocConsumer<MerchantRegisterBloc, MerchantRegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AuthStatusWrapper()));
            } else if (state is MerchantRegisterFailure) {
              showSnackbar(context: context, message: state.message);
            }
          },
          builder: (context, state) {
            if (state is MerchantRegisterInitial) {
              return MerchantRegisterForm();
            } else if (state is MerchantRegisterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MerchantRegisterSuccess) {
              return Container();
            } else {
              return const Center(
                child: Text(
                  'state is not implemented',
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

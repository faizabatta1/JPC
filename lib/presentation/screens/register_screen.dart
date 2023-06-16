import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:jpc/presentation/wrappers/auth_status_wrapper.dart';

import '../widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  static const String register = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => RegisterBloc()..add(ResetRegisterInitial()),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthStatusWrapper()));
              } else if (state is RegisterFailure) {
                showSnackbar(context: context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is RegisterInitial) {
                return RegisterForm();
              } else if (state is RegisterLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RegisterSuccess) {
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
      ),
    );
  }
}

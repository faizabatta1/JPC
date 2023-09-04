import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/utils/show_snackbar.dart';
import 'package:jpc/presentation/blocs/auth_status/auth_status_bloc.dart';
import 'package:jpc/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:jpc/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:jpc/presentation/screens/register_screen.dart';

import '../../core/routing/login_router.dart';
import '../../core/routing/merchant_login_router.dart';
import '../blocs/merchant_login_bloc/merchant_login_bloc.dart';


class MerchantLoginScreenNavigator extends StatefulWidget {
  static const String merchantLogin = '/merchant/login';
  const MerchantLoginScreenNavigator({super.key});

  @override
  State<MerchantLoginScreenNavigator> createState() => _LoginScreenNavigatorState();
}

class _LoginScreenNavigatorState extends State<MerchantLoginScreenNavigator> {

  final GlobalKey<NavigatorState> _nestedNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MerchantLoginBloc()..add(ResetMerchantLoginInitial()),
      child: BlocConsumer<MerchantLoginBloc,MerchantLoginState>(
        listener: (context,state){
          if(state is MerchantNotFound){
            showSnackbar(context: context, message: "User Not Found");
          }else if(state is MerchantWrongCredentials){
            showSnackbar(context: context, message: "Wrong Credentials");
          }else if(state is MerchantLoginSuccess){
            showSnackbar(context: context, message: "Logged in Successfully");
            AuthStatusBloc.sink.add(AuthUserActiveEvent());
          }
        },

        builder: (context,state){
          if(state is MerchantLoginLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is MerchantUnknownState){
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('something unknown in login')
                ],
              ),
            );
          }

          return Navigator(
            key: _nestedNavigatorKey,
            onGenerateRoute: MerchantLoginRouter.generatedRoute,
            initialRoute: MerchantLoginScreenNavigator.merchantLogin,
          );
        },
      ),
    );
  }
}
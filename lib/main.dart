import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jpc/presentation/blocs/auth_status/auth_status_bloc.dart';
import 'package:jpc/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:jpc/presentation/blocs/merchant_login_bloc/merchant_login_bloc.dart';
import 'package:jpc/presentation/blocs/merchant_register_bloc/merchant_register_bloc.dart';
import 'package:jpc/presentation/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:jpc/presentation/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:jpc/presentation/blocs/products_bloc/products_bloc.dart';

import 'App.dart';
import 'core/helpers/SQFLiteHelper.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );
  MobileAds.instance.initialize();
  Stripe.publishableKey = 'pk_test_51N3EcJHHXVdH5ff2jGAGw29e2WcAlleHgFOwEQPm2jQARp6qIUiLBcspeDK4uUzYe2OYmq1tGXFipk630A8nVGgK00pLHqNjp3';
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  await SqfliteHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // final AuthStatusBloc authStatusBloc = AuthStatusBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AuthStatusBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationsBloc(),
        ),
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => ProductDetailsBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => MerchantLoginBloc()),
        BlocProvider(create: (context) => MerchantRegisterBloc()),
      ],
      child: App(),
    );
  }
}


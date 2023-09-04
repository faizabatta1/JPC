import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jpc/data/models/merchant.dart';

part 'merchant_register_event.dart';
part 'merchant_register_state.dart';

class MerchantRegisterBloc extends Bloc<MerchantRegisterEvent, MerchantRegisterState> {
  MerchantRegisterBloc() : super(MerchantRegisterInitial()) {
    on<MerchantRegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

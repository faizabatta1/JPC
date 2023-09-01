import 'dart:math';

import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/datasource/local/notifications_data/notifications_local_data_source_impl.dart';
import '../../../data/models/fcm_notification.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

void requestPermission() async {



}

var channel;
var flutterLocalNotificationsPlugin;

void loadFCM() async {
  channel = const AndroidNotificationChannel(
    'jpc_user_notifications_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    enableVibration: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

}

void listenFCM() async {
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationState> {
  final int _perPage = 20;

  NotificationsBloc() : super(const NotificationState()) {
    requestPermission();
    loadFCM();
    listenFCM();

    NotificationsLocalDataSourceImpl notificationsLocalDataSourceImpl = NotificationsLocalDataSourceImpl();

    on<NotificationsEvent>((event, emit) async{
      if(event is FetchNotifications){
        if(state.hasReachedMax) return;

        try{
          if(state.status == NotificationStatus.loading){
            List<FCMNotification> notifications = await notificationsLocalDataSourceImpl.fetchNotifications(limit: _perPage,offset: 0);
            return emit(
              state.copyWith(
                status: NotificationStatus.success,
                notifications: notifications,
                hasReachedMax: false
              )
            );
          }else{
            List<FCMNotification> notifications = await notificationsLocalDataSourceImpl.fetchNotifications(limit: _perPage,offset: state.notifications.length);
            if(notifications.isEmpty){
              emit(state.copyWith(hasReachedMax: true));
            }else{
              emit(
                state.copyWith(
                  status: NotificationStatus.success,
                  notifications: List.of(state.notifications)..addAll(notifications),
                  hasReachedMax: false
                )
              );
            }
          }
        }catch(e){
          emit(state.copyWith(status: NotificationStatus.error,errorMessage: "failed to get posts"));
        }
      }
    },transformer: droppable());
  }
}

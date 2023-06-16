import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jpc/core/error_handling/fcm_store_notification_error.dart';

import 'package:jpc/data/models/fcm_notification.dart';

import '../../../../core/helpers/SQFLiteHelper.dart';
import 'notifications_local_data_source.dart';

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource{

  @override
  Future<bool> deleteNotification(int id) async{
    Database database = await SqfliteHelper().database;
    try{
      return await database.delete('notifications',where: 'id = ?',whereArgs: [id]) > 0;
    }catch(deleteError){
      return false;
    }
  }

  @override
  Future<List<FCMNotification>> fetchNotifications({
    required int limit, required int offset
  }) async{
    Database database = await SqfliteHelper().database;
    List rows = await database.query('notifications',limit: limit,offset: offset);
    List<FCMNotification> notifications = rows.map((notification) => FCMNotification.fromJson(notification))
        .toList();

    // return notifications;
    List<FCMNotification> notifications_ = List.generate(120, (index) => FCMNotification(
        title: '${Random().nextInt(20000)}',
        body: '${Random().nextInt(20000)}',
        sendTime: (index + 1).toString()
    ));

    return await Future.delayed(Duration(seconds: 2),(){
      return offset >= notifications_.length ? [] : notifications_.sublist(offset,offset + limit);
    });
  }

  @override
  Future<Either<FCMStoreNotificationError, bool>> storeNotification(FCMNotification notification) async{
    Database database = await SqfliteHelper().database;
    try{
      int insertion = await database.insert('notifications', notification.toJson());
      return insertion > 0 ? const Right(true) : Left(FCMStoreNotificationError(''));
    }catch(insertionError){
      return Left(FCMStoreNotificationError(''));
    }
  }
}
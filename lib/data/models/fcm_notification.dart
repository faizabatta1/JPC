
class FCMNotification{
  final String title;
  final String body;
  final String sendTime;

  const FCMNotification({
    required this.title,
    required this.body,
    required this.sendTime,
  });

  factory FCMNotification.nullFCM(){
    return const FCMNotification(
      title: 'no title',
      body: 'no body',
      sendTime: 'today'
    );
  }

  factory FCMNotification.fromRemote(Map notification){

    if(notification != null){
      return FCMNotification(
        title: notification['title']!,
        body: notification['body'],
        sendTime: DateTime.now().toString()
      );
    }else{
      return FCMNotification.nullFCM();
    }
  }

  factory FCMNotification.fromJson(Map<String,Object?> json){
    return FCMNotification(
      title: json['title'] as String,
      body: json['body'] as String,
      sendTime: json['sendTime'] as String,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'title': title,
      'body': body,
      'sendTime': sendTime
    };
  }
}
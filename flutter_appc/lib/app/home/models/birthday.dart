import 'package:flutter/foundation.dart';

class Birthday {
  Birthday({
    @required this.id,
    @required this.brithDay,
  });

  String id;
  DateTime brithDay;
  factory Birthday.fromMap(Map<dynamic, dynamic> value, String id) {
    final int myBirthday = value['my_birthday'];
    return Birthday(
      id: id,
      brithDay: DateTime.fromMillisecondsSinceEpoch(myBirthday),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'my_birthday': brithDay.millisecondsSinceEpoch,
    };
  }
}
import 'package:flutter/foundation.dart';

class Friend {
  Friend({
    @required this.id,
    @required this.name,
    @required this.start,
    @required this.end,
    this.comment,
  });

  String id;
  String name;
  DateTime start;
  DateTime end;
  String comment;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Friend.fromMap(Map<dynamic, dynamic> value, String id) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    return Friend(
      id: id,
      name: value['profileId'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profileId': name,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }
}

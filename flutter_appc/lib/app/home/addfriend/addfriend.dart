import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/job.dart';
import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/database.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({Key key, @required this.database, this.job})
      : super(key: key);
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => AddFriend(database: database, job: job),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColorLight,
        bottom: null,
      ),
    );
  }
}

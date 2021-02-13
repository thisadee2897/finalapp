import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/account.dart';
import 'package:flutter_appc/app/home/models/birthday.dart';

class BirthDayTile extends StatelessWidget {
  const BirthDayTile({Key key, @required this.birthDay, this.onTap})
      : super(key: key);
  final Birthday birthDay;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(birthDay.brithDay.toString()),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

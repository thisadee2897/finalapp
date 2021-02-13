import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/email.dart';

class EmailListTile extends StatelessWidget {
  const EmailListTile(
      {Key key, @required this.email, this.onTap, this.onDelete})
      : super(key: key);
  final Email email;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(Iconsem),
      title: Text(email.email),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}

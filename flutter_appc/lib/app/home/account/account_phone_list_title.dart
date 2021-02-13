import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/phone.dart';

class PhoneListTile extends StatelessWidget {
  const PhoneListTile(
      {Key key, @required this.phone, this.onTap, this.onDelete})
      : super(key: key);
  final Phone phone;
  final VoidCallback onTap;

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(phone.phoneNumber),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}

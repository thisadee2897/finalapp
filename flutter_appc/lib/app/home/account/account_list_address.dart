import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/place.dart';

class AddressListTile extends StatelessWidget {
  const AddressListTile({Key key, @required this.address, this.onTap})
      : super(key: key);
  final Place address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(address.address),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/place.dart';

class AddressListTile extends StatelessWidget {
  const AddressListTile(
      {Key key, @required this.address, this.onTap, this.onDelete})
      : super(key: key);
  final Place address;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(address.address),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: Colors.grey.shade400,
        ),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/account.dart';
import 'package:flutter_appc/app/home/models/place.dart';
import 'package:flutter_appc/common_widgets/custom_raised_button.dart';
import 'package:flutter_appc/common_widgets/show_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/database.dart';

class AccountAddPlace extends StatefulWidget {
  const AccountAddPlace({Key key, @required this.database, this.myAddress})
      : super(key: key);
  final Database database;
  final Place myAddress;

  static Future<void> show(BuildContext context,
      {Database database, Place address}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => AccountAddPlace(
          database: database,
          myAddress: address,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AccountAddPlaceState createState() => _AccountAddPlaceState();
}

class _AccountAddPlaceState extends State<AccountAddPlace> {
  String _address;

  @override
  void initState() {
    super.initState();
    if (widget.myAddress != null) {
      _address = widget.myAddress.address;
    }
  }

  final _formKey = GlobalKey<FormState>();

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      print("ตรวจสอบผ่าน");
      try {
        final data = await widget.database.addresssStream().first;
        final allNames =
            data.map((addressData) => addressData.address).toList();
        if (widget.myAddress != null) {
          print('ข้อมูลเข้าI');
          allNames.remove(widget.myAddress.address);
        }
        if (allNames.contains(_address)) {
          showAlertDialog(
            context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          );
        } else {
          print('ข้อมูลเข้าII');
          final id = widget.myAddress?.id ?? documentIdFromCurrentDate();
          final address = Place(id: id, address: _address);
          await widget.database.setAddress(address);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
        );
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myAddress == null ? 'เพิ่มที่อยู่' : 'แก้ไขที่อยู่'),
        backgroundColor: MyColors.primaryColorLight,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _address,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_pin),
                      labelText: 'ที่อยู่',
                    ),
                    onSaved: (value) => _address = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomRaisedButton(
                    child: Text(
                      'บันทึก',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    color: MyColors.primaryColorLight,
                    onPressed: _submit,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/phone.dart';
import 'package:flutter_appc/common_widgets/custom_raised_button.dart';
import 'package:flutter_appc/common_widgets/show_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/database.dart';

class AccountAddPhone extends StatefulWidget {
  const AccountAddPhone({Key key, @required this.database, this.myPhoneNumber})
      : super(key: key);
  final Database database;
  final Phone myPhoneNumber;
  static Future<void> show(BuildContext context,
      {Database database, Phone phoneNumber}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) =>
            AccountAddPhone(database: database, myPhoneNumber: phoneNumber),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AccountAddPhoneState createState() => _AccountAddPhoneState();
}

class _AccountAddPhoneState extends State<AccountAddPhone> {
  String _phone;

  @override
  void initState() {
    super.initState();
    if (widget.myPhoneNumber != null) {
      _phone = widget.myPhoneNumber.phoneNumber;
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
        final data = await widget.database.phonesStream().first;
        final allNames =
            data.map((phoneData) => phoneData.phoneNumber).toList();
        if (widget.myPhoneNumber != null) {
          print('ข้อมูลเข้าI');
          allNames.remove(widget.myPhoneNumber.phoneNumber);
        }
        if (allNames.contains(_phone)) {
          showAlertDialog(
            context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          );
        } else {
          print('ข้อมูลเข้าII');
          final id = widget.myPhoneNumber?.id ?? documentIdFromCurrentDate();
          final phones = Phone(id: id, phoneNumber: _phone);
          await widget.database.setPhone(phones);
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
        title: Text(widget.myPhoneNumber == null
            ? 'เพิ่มหมายเลขโทรศัพท์'
            : 'แก้ไขหมายเลขโทรศัพท์'),
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
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone_android),
                      labelText: 'หมายเลขโทรศัพท์',
                    ),
                    initialValue: _phone,
                    validator: (value) =>
                        value.isNotEmpty ? null : 'ข้อมูลว่างเปล่า',
                    onSaved: (value) => _phone = value,
                    keyboardType: TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomRaisedButton(
                    child: Text(
                      'ว่าง',
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

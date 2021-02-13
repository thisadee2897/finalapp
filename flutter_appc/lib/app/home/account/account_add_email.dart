import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/email.dart';
import 'package:flutter_appc/common_widgets/custom_raised_button.dart';
import 'package:flutter_appc/common_widgets/show_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/database.dart';

class AccountAddEmail extends StatefulWidget {
  const AccountAddEmail({Key key, @required this.database, this.myemail})
      : super(key: key);
  final Database database;
  final Email myemail;

  static Future<void> show(BuildContext context,
      {Database database, Email email}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => AccountAddEmail(
          database: database,
          myemail: email,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AccountAddEmailState createState() => _AccountAddEmailState();
}

class _AccountAddEmailState extends State<AccountAddEmail> {
  String _email;

  @override
  void initState() {
    super.initState();
    if (widget.myemail != null) {
      _email = widget.myemail.email;
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
        final data = await widget.database.emailsStream().first;
        final allNames = data.map((emailData) => emailData.email).toList();
        if (widget.myemail != null) {
          print('ข้อมูลเข้าI');
          allNames.remove(widget.myemail.email);
        }
        if (allNames.contains(_email)) {
          showAlertDialog(
            context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          );
        } else {
          print('ข้อมูลเข้าII');
          final id = widget.myemail?.id ?? documentIdFromCurrentDate();
          final emails = Email(id: id, email: _email);
          await widget.database.setEmail(emails);
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
        title: Text(widget.myemail == null ? 'New Email' : 'Edit Email'),
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
                    initialValue: _email,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    onSaved: (value) => _email = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomRaisedButton(
                    child: Text(
                      'Save',
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

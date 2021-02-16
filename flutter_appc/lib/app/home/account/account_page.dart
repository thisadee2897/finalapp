import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appc/app/home/account/account_list_address.dart';
import 'package:flutter_appc/app/home/models/birthday.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appc/app/home/account/account_add_address.dart';
import 'package:flutter_appc/app/home/account/account_add_email.dart';
import 'package:flutter_appc/app/home/account/account_addphone.dart';
import 'package:flutter_appc/app/home/account/account_birthday_tile.dart';
import 'package:flutter_appc/app/home/account/account_list_email.dart';
import 'package:flutter_appc/app/home/jobs/list_items_builder.dart';
import 'package:flutter_appc/app/home/models/email.dart';
import 'package:flutter_appc/app/home/models/phone.dart';
import 'package:flutter_appc/app/home/models/place.dart';
import 'package:flutter_appc/common_widgets/avatar.dart';

import 'package:flutter_appc/common_widgets/date_time_picker.dart';
import 'package:flutter_appc/common_widgets/show_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/auth.dart';
import 'package:flutter_appc/services/database.dart';

import 'account_phone_list_title.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    @required this.birthday,
  });
  final Birthday birthday;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  DateTime _myHBD;

  @override
  void initState() {
    super.initState();
    final bD = widget.birthday?.brithDay ?? DateTime.now();
    _myHBD = DateTime(bD.year, bD.month, bD.day);
  }

  Birthday _birthdayFromState() {
    final selected = DateTime(_myHBD.year, _myHBD.month, _myHBD.day);
    final id = widget.birthday?.id ?? documentIdFromCurrentDate();
    return Birthday(
      id: id,
      brithDay: selected,
    );
  }

  get database => Provider.of<Database>(context, listen: false);

  Future<void> _setBirthDay(BuildContext context) async {
    try {
      final birthDay = _birthdayFromState();
      await database.setBirthday(birthDay);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  Future<void> _deletePhone(BuildContext context, Phone _data) async {
    final didRequestDelete = await showAlertDialog(
      context,
      title: 'ลบ ${_data.phoneNumber.characters}',
      content: 'แน่ใจไหมว่าต้องการลบ?',
      cancelActionText: 'ยกเลิก',
      defaultActionText: 'ลบ',
    );
    if (didRequestDelete == true) {
      final database = Provider.of<Database>(context, listen: false);
      await database.deletePhone(_data);
    }
  }

  Future<void> _deleteAddress(BuildContext context, Place _data) async {
    final didRequestDelete = await showAlertDialog(
      context,
      title: 'ลบ ${_data.address.characters}',
      content: 'แน่ใจไหมว่าต้องการลบ?',
      cancelActionText: 'ยกเลิก',
      defaultActionText: 'ลบ',
    );
    if (didRequestDelete == true) {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteAddress(_data);
    }
  }

  Future<void> _confirmdeletemail(BuildContext context, Email _data) async {
    final didRequestDelete = await showAlertDialog(
      context,
      title: 'ลบ ${_data.email.characters}',
      content: 'แน่ใจไหมว่าต้องการลบ?',
      cancelActionText: 'ยกเลิก',
      defaultActionText: 'ลบ',
    );
    if (didRequestDelete == true) {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteEmail(_data);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'ออกจากระบบ',
      content: 'แน่ใจไหมว่าต้องการออก?',
      cancelActionText: 'ยกเลิก',
      defaultActionText: 'ออก',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.primaryColorLight,
        title: Text('Account'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _setBirthDay(context),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _confirmSignOut(context),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfo(auth.currentUser),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // _buildDate(context),
              _buildBirthDay(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: GestureDetector(
                      onTap: () => AccountAddPhone.show(
                        context,
                        database: Provider.of<Database>(context, listen: false),
                      ),
                      child: Text(
                        "เพิ่มหมายเลขโทรศัพท์",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  _buildPhone(context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: GestureDetector(
                      onTap: () => AccountAddEmail.show(
                        context,
                        database: Provider.of<Database>(context, listen: false),
                      ),
                      child: Text(
                        "เพิ่มอีเมล์",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  _buildEmail(context),
                ],
              ),
              // _buildPhones(context)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: GestureDetector(
                      onTap: () => AccountAddPlace.show(
                        context,
                        database: Provider.of<Database>(context, listen: false),
                      ),
                      child: Text(
                        "เพิ่มที่อยู่",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  _buildAddress(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhones(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // color: Colors.green,
            child: Center(
              child: StreamBuilder<List<Phone>>(
                  stream: database.phonesStream(),
                  builder: (context, snapshot) {
                    var listPhone = snapshot.data;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Image.asset('assets/phone.png')),
                        ),
                        for (var phoneNumber in listPhone)
                          Container(
                            child: ListTile(
                              title: Text('${phoneNumber.toString()}'),
                              leading: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.call),
                              ),
                              // subtitle: Text('subtitle'),
                              trailing: IconButton(
                                icon: Icon(Icons.copy_sharp),
                                onPressed: () async {
                                  await Clipboard.setData(new ClipboardData(
                                      text: "${phoneNumber.toString()}"));
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('${phoneNumber.toString()}')));
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBirthDay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DatePicker(
            myOld: Text(
                '${((DateTime.now().difference(_myHBD).inDays / 365.25).floor()).toString()}'),
            selectedDate: _myHBD,
            onSelectedDate: (date) => setState(() => _myHBD = date),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoURL,
          radius: 50,
        ),
        SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPhone(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Phone>>(
            stream: database.phonesStream(),
            builder: (context, snapshot) {
              return ListItemsBuilder<Phone>(
                snapshot: snapshot,
                itemBuilder: (context, _num) => PhoneListTile(
                  onDelete: () => _deletePhone(context, _num),
                  phone: _num,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountAddPhone(
                          database: database, myPhoneNumber: _num),
                      fullscreenDialog: false,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<Email>>(
                stream: database.emailsStream(),
                builder: (context, snapshot) {
                  return ListItemsBuilder<Email>(
                    snapshot: snapshot,
                    itemBuilder: (context, _emailData) => EmailListTile(
                      onDelete: () => _confirmdeletemail(context, _emailData),
                      email: _emailData,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AccountAddEmail(
                            database: database,
                            myemail: _emailData,
                          ),
                          fullscreenDialog: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<Place>>(
                stream: database.addresssStream(),
                builder: (context, snapshot) {
                  return ListItemsBuilder<Place>(
                    snapshot: snapshot,
                    itemBuilder: (context, _addressData) => AddressListTile(
                      address: _addressData,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AccountAddPlace(
                            database: database,
                            myAddress: _addressData,
                          ),
                          fullscreenDialog: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildAddress(BuildContext context) {
  //   return StreamBuilder<List<Place>>(
  //     stream: database.addresssStream(),
  //     builder: (context, snapshot) {
  //       var address = snapshot.data;
  //       return Container(
  //         color: Colors.redAccent,
  //         child: Text(address.toString()),
  //       );
  //     },
  //   );
  // }

  // Widget _buildAge() {
  //   final database = Provider.of<Database>(context, listen: false);
  //   return StreamBuilder<List<Birthday>>(
  //     stream: database.birthdayStream(),
  //     builder: (context, snapshot) {
  //       return ListTile(
  //           title: Row(
  //             children: [
  //               Text("${_myHBD.toLocal()}".split(' ')[0]),
  //               SizedBox(
  //                 width: 30,
  //               ),
  //               Text(
  //                   'อายุ ${(DateTime.now().difference(_myHBD).inDays / 365.25).floor()} ปี'),
  //             ],
  //           ),
  //           trailing: Icon(Icons.calendar_today),
  //           onTap: () {
  //             // _selectDate(context);
  //           });
  //     },
  //   );
  // }

  // _buildDate(BuildContext context) {
  //   final database = Provider.of<Database>(context, listen: false);
  //   return StreamBuilder<List<Birthday>>(
  //     stream: database.birthdayStream(),
  //     builder: (context, snapshot) {
  //       return ListItemsBuilder<Birthday>(
  //         snapshot: snapshot,
  //         itemBuilder: (context, _num) => Dismissible(
  //           key: Key('birth-${_num.id}'),
  //           background: Container(color: Colors.red),
  //           direction: DismissDirection.endToStart,
  //           child: BirthDayTile(
  //             onTap: () => _setBirthDay(context),
  //             birthDay: _num,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appc/app/home/notification/entries_bloc.dart';

import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountFriend extends StatefulWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Provider<EntriesBloc>(
      create: (_) => EntriesBloc(database: database),
      child: AccountFriend(),
    );
  }

  @override
  _AccountFriendState createState() => _AccountFriendState();
}

class _AccountFriendState extends State<AccountFriend> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  get database => Provider.of<Database>(context, listen: false);

  get emailList => [
        'Chakkapat02@gmail.com',
        'Chakkapat89@gmail.com',
        'Chakkapat_se@gmail.com',
      ];

  get phoneList => [
        '0878459249',
        '0993846820',
      ];

  get addressList => ['มหาวิทยาลัยเทคโนโลยีราชมงคลอีสาน วิทยาเขตสกลนคร'];

  get photoUrl => 'assets/2.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: MyColors.primaryColorLight,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: buildImage(),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPhone(context),
              _buildEmail(context),
              _buildAddress(context),
              // _buildMore()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
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
              child: Column(
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
                  for (var _num in phoneList)
                    Container(
                      child: ListTile(
                        title: Text('${_num.toString()}'),
                        leading: IconButton(
                          onPressed: () async {
                            final phoneNumber = "tel:${_num.toString()}";
                            if (await canLaunch(phoneNumber)) {
                              await launch(phoneNumber);
                            } else {
                              throw 'Could not launch $phoneNumber';
                            }
                          },
                          icon: Icon(Icons.call),
                        ),
                        // subtitle: Text('subtitle'),
                        trailing: IconButton(
                          icon: Icon(Icons.copy_sharp),
                          onPressed: () async {
                            await Clipboard.setData(
                                new ClipboardData(text: "${_num.toString()}"));
                            final snackBar = new SnackBar(
                              backgroundColor: MyColors.primaryColorLight,
                              content: new Text(
                                "${_num.toString()}",
                                style: new TextStyle(color: Colors.white),
                              ),
                              action: new SnackBarAction(
                                disabledTextColor: Colors.red,
                                textColor: Colors.white,
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change!
                                },
                              ),
                            );
                            _scaffoldstate.currentState.showSnackBar(snackBar);
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: MyColors.primaryColorLight,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black12,
              backgroundImage: photoUrl != null ? AssetImage(photoUrl) : null,
              child: photoUrl == null ? Icon(Icons.camera_alt, size: 30) : null,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Chakkapat Saenphisan',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          // if (user.displayName != null)
          //   Text(
          //     user.displayName,
          //     style: TextStyle(color: Colors.white, fontSize: 18),
          //   ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Container(
          // width: double.infinity,
          // height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/mail.png')),
                ),
                for (var i in emailList)
                  ListTile(
                    title: Text('${i.toString()}'),
                    leading: IconButton(
                      onPressed: () => openEmailApp(context, i),
                      icon: Icon(Icons.mail_outline),
                    ),
                    // subtitle: Text('subtitle'),
                    trailing: IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            new ClipboardData(text: "${i.toString()}"));
                        final snackBar = new SnackBar(
                          backgroundColor: MyColors.primaryColorLight,
                          content: new Text(
                            "${i.toString()}",
                            style: new TextStyle(color: Colors.white),
                          ),
                          action: new SnackBarAction(
                            disabledTextColor: Colors.red,
                            textColor: Colors.white,
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change!
                            },
                          ),
                        );
                        _scaffoldstate.currentState.showSnackBar(snackBar);
                      },
                      icon: Icon(Icons.copy_sharp),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/Place.png')),
                for (var i in addressList)
                  ListTile(
                    title: Text('${i.toString()}'),
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_pin),
                    ),
                    // subtitle: Text('subtitle'),
                    trailing: IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            new ClipboardData(text: "${i.toString()}"));
                        final snackBar = new SnackBar(
                          backgroundColor: MyColors.primaryColorLight,
                          content: new Text(
                            "${i.toString()}",
                            style: new TextStyle(color: Colors.white),
                          ),
                          action: new SnackBarAction(
                            disabledTextColor: Colors.red,
                            textColor: Colors.white,
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change!
                            },
                          ),
                        );
                        _scaffoldstate.currentState.showSnackBar(snackBar);
                      },
                      icon: Icon(Icons.copy_sharp),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMore() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        elevation: 6,
        shadowColor: MyColors.primaryColorLight,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Container(
          width: double.infinity,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/map.png')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _builddata() {
    return ListView(
      shrinkWrap: true,
      children: [
        for (var i in phoneList)
          Card(
            child: ListTile(
              title: Text('${i.toString()}'),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.call),
              ),
              subtitle: Text('subtitle'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy_sharp),
              ),
            ),
          ),
        for (var i in emailList)
          Card(
            child: ListTile(
              title: Text('${i.toString()}'),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.mail_outline),
              ),
              subtitle: Text('subtitle'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy_sharp),
              ),
            ),
          ),
        for (var i in addressList)
          Material(
            color: Colors.white,
            shadowColor: MyColors.primaryColorLight,
            child: ListTile(
              title: Text('${i.toString()}'),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.location_pin),
              ),
              subtitle: Text('subtitle'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy_sharp),
              ),
            ),
          ),
      ],
    );
  }

  _launchCaller(BuildContext context, _num) async {
    final url = "tel:${_num.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> openEmailApp(BuildContext context, i) async {
    final url = 'mailto:${i.toString()}?subject=test&body=hello';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

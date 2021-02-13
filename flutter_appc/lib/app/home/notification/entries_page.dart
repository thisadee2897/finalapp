import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appc/app/home/jobs/list_items_builder.dart';
import 'package:flutter_appc/app/home/notification/entries_bloc.dart';
import 'package:flutter_appc/app/home/notification/entries_list_tile.dart';
import 'package:flutter_appc/common_widgets/theme.dart';
import 'package:flutter_appc/services/database.dart';

class NotificationPage extends StatelessWidget {
  String now = DateFormat("hh:mm dd/MM/yy").format(DateTime.now());
  String get image => "assets/01.jpg";
  String get name => "Thisadee Chornbulom";
  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Provider<EntriesBloc>(
      create: (_) => EntriesBloc(database: database),
      child: NotificationPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildnewfriend(context),
              _buildnewfriend(context),
              _buildnewfriend(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final bloc = Provider.of<EntriesBloc>(context, listen: false);
    return StreamBuilder<List<EntriesListTileModel>>(
      stream: bloc.entriesTileModelStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<EntriesListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => EntriesListTile(model: model),
        );
      },
    );
  }

  Widget _buildnewfriend(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 130,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Text(
                    '${now.toString()}',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(image),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'ต้องการเชื่อมต่อกับคุณ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    children: [
                      InkWell(
                        child: Material(
                          shadowColor: Colors.black38,
                          color: MyColors.primaryColorLight,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 35,
                            width: 100,
                            child: Center(
                              child: Text(
                                'ยืนยัน',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          print('OK');
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          print('No');
                        },
                        child: Material(
                          color: Colors.grey.shade500,
                          shadowColor: Colors.black38,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 35,
                            width: 100,
                            // color: Colors.grey,
                            child: Center(
                                child: Text(
                              'ปฎิเสธ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

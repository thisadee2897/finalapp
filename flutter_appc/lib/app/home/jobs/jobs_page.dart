import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appc/app/home/Friends/cardprofile.dart';
import 'package:flutter_appc/app/home/account_friend/account_friend.dart';
import 'package:flutter_appc/app/home/addfriend/search_friend.dart';
import 'package:flutter_appc/app/home/job_entries/job_entries_page.dart';
import 'package:flutter_appc/app/home/jobs/edit_job_page.dart';
import 'package:flutter_appc/app/home/jobs/job_list_tile.dart';
import 'package:flutter_appc/app/home/jobs/list_items_builder.dart';
import 'package:flutter_appc/app/home/models/job.dart';
import 'package:flutter_appc/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_appc/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'เพื่อนทั้งหมด',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person_add_sharp, color: Colors.black54),
              onPressed: () =>
                  showSearch(context: context, delegate: SearchFriend())),
          // IconButton(
          //   icon: Icon(Icons.group_add_sharp, color: Colors.white),
          //   onPressed: () => AddFriend.show(
          //     context,
          //     database: Provider.of<Database>(context, listen: false),
          //   ),
          // ),
          // IconButton(
          //   icon: Icon(Icons.add, color: Colors.black54),
          //   onPressed: () => EditJobPage.show(
          //     context,
          //     database: Provider.of<Database>(context, listen: false),
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: _profileFriend(context),
      ),
      // body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }

  Widget _profileFriend(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      height: double.infinity,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: home_items.length,
          itemBuilder: (BuildContext context, int index) {
            return CardGrid(
                onPress: () {
                  Navigator.of(context, rootNavigator: false).push(
                      MaterialPageRoute(builder: (context) => AccountFriend()));
                },
                name: home_items[index].name.split(' ')[0],
                rating: home_items[index].ratings,
                profile: home_items[index].logo_path);
          }),
    );
  }
}

List<ModelGrid> home_items = [
  ModelGrid(
      name: "thisadee jornburommmmmmmmmmmmmmmm",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/01.jpg',
      image_path: 'assets/01.jpg'),
  ModelGrid(
      name: "Jackapat jantaart",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/2.jpg',
      image_path: 'assets/2.jpg'),
  ModelGrid(
      name: "kraiwit jamparat",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/3.jpg',
      image_path: 'assets/3.jpg'),
  ModelGrid(
      name: "Jumanji",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/4.jpg',
      image_path: 'assets/4.jpg'),
  ModelGrid(
      name: "pookkie ",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/5.jpg',
      image_path: 'assets/5.jpg'),
  ModelGrid(
      name: "nantakorn butyotee",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/6.jpg',
      image_path: 'assets/6.jpg'),
  ModelGrid(
      name: "Jumanji",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/01.jpg',
      image_path: 'assets/6.jpg'),
  ModelGrid(
      name: "Jumanji",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/5.jpg',
      image_path: 'assets/6.jpg'),
  ModelGrid(
      name: "Jumanji",
      subtitle:
          "When Spencer goes back into the fantastical world of Jumanji, pals Martha, Fridge and ",
      ratings: "6.0",
      logo_path: 'assets/4.jpg',
      image_path: 'assets/4.jpg'),
];

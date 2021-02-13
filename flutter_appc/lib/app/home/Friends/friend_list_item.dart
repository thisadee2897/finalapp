import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/job_entries/format.dart';
import 'package:flutter_appc/app/home/models/account.dart';
import 'package:flutter_appc/app/home/models/accountfriend.dart';
import 'package:flutter_appc/app/home/models/entry.dart';
import 'package:flutter_appc/app/home/models/job.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({
    @required this.friend,
    @required this.myAccount,
    @required this.onTap,
  });

  final Friend friend;
  final Profile myAccount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final dayOfWeek = Format.dayOfWeek(friend.start);
    final startTime = TimeOfDay.fromDateTime(friend.start).format(context);
    final endTime = TimeOfDay.fromDateTime(friend.end).format(context);
    final durationFormatted = Format.hours(friend.durationInHours);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(dayOfWeek, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          SizedBox(width: 15.0),
        ]),
        Row(children: <Widget>[
          Text('$startTime - $endTime', style: TextStyle(fontSize: 16.0)),
          Expanded(child: Container()),
          Text(durationFormatted, style: TextStyle(fontSize: 16.0)),
        ]),
        if (friend.comment.isNotEmpty)
          Text(
            friend.comment,
            style: TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}

class DismissibleEntryListItem extends StatelessWidget {
  const DismissibleEntryListItem({
    this.key,
    this.entry,
    this.job,
    this.onDismissed,
    this.onTap,
  });

  final Key key;
  final Entry entry;
  final Job job;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(),
      child: FriendListItem(
        onTap: onTap,
        myAccount: null,
        friend: null,
      ),
    );
  }
}

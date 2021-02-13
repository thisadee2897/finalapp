import 'package:flutter/material.dart';

enum TabItem { jobs, account, entries }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.jobs:
        TabItemData(title: 'เพื่อน', icon: Icons.supervisor_account_sharp),
    TabItem.account: TabItemData(title: 'ฉัน', icon: Icons.person),
    TabItem.entries:
        TabItemData(title: 'แจ้งเตือน', icon: Icons.notifications_active),
  };
}

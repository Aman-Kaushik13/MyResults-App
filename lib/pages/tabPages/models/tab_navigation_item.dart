import 'package:cool_project/Home.dart';
import 'package:flutter/material.dart';
import '../assignments.dart';
import '../evalute_page.dart';


class TabNavigationItem {
  final Widget page;

  TabNavigationItem({@required this.page});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(page: MyHomePage()),
        TabNavigationItem(page: ChartPage()),
        TabNavigationItem(page: AssignmentPage()),
      ];
}

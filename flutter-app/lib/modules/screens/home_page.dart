import 'package:flutter/material.dart';
import 'package:logbook/modules/tabs/goals_tab.dart';
import 'package:logbook/modules/tabs/logs_tab.dart';
import 'package:logbook/modules/widgets/app_drawer.dart';
import 'package:logbook/shared/theme/main_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  late TabController tabController = TabController(length: 2, vsync: this);

  List<Tab>tabIcons = [
    Tab(
      icon: Icon(Icons.library_books),
      text: "Diário de Bordo",
    ),
    Tab(
      icon: Icon(Icons.map),
      text: "Tesouros",
    ),
  ];

  List<Widget> tabPages = [
    LogsTab(),
    GoalsTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logbook"),
        backgroundColor: MainColors.gray,
      ),
      backgroundColor: MainColors.black,
      drawer: AppDrawer(),
      body: TabBarView(
        controller: tabController,
        children: tabPages,
      ),
      bottomNavigationBar: Container(
        child: TabBar(
          tabs: tabIcons,
          controller: tabController,
          indicatorColor: MainColors.blue,
        ),
      ),
    );
  }
}
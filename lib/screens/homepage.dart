import 'package:dg_admin/screens/dashboard.dart';
import 'package:dg_admin/screens/manage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Icon> icons = [
    Icon(
      Icons.people_outline,
      color: Colors.grey.shade700,
    ),
    Icon(Icons.category, color: Colors.grey.shade700),
    Icon(Icons.track_changes, color: Colors.grey.shade700),
    Icon(Icons.shopping_cart, color: Colors.grey.shade700),
    Icon(Icons.close, color: Colors.grey.shade700),
  ];
  List name = ["Users", "Categories", "Products", "Orders", "Return"];
  List productnumber = ["7", "23", "120", "5", "0"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              color: Colors.white,
              child: TabBar(
                  // automaticIndicatorColorAdjustment: false,
                  labelColor: Color(0xFFFFAB40),
                  indicatorColor: Colors.orange.shade400,
                  indicatorWeight: 1.5,
                  // dragStartBehavior: DragStartBehavior.down,
                  tabs: [
                    Tab(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Icon(
                            Icons.dashboard,
                            // color: Colors.orangeAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Dashboard",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    )),
                    Tab(
                        child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          // color: Colors.orangeAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            style: TextStyle(color: Colors.black),
                            "Manage",
                          ),
                        )
                      ],
                    ))
                  ]),
            ),
          ),
        ),
        body: TabBarView(children: [Dashboard(), Manage()]),
      ),
    );
  }
}

import 'package:flutter/material.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

var myDefaultBackground = Colors.grey[300];

var myAppBar = AppBar(
  backgroundColor: Colors.grey[900],
  leading: IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () {
      // Open drawer
      scaffoldKey.currentState?.openDrawer();
    },
    color: Colors.white54, // 这里修改了图标的颜色
  ),
);

var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  child: const Column(
    children: [
      DrawerHeader(child: Icon(Icons.favorite)),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("D A S H B O A R D"),
      ),
      ListTile(
        leading: Icon(Icons.chat),
        title: Text("M E S S A G E"),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("S E T T I N G S"),
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("L O G O U T"),
      ),
    ],
  ),
);

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: identical(0, 0.0) ? null : "微软雅黑",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      /// PC, 手机, 响应布局
      // home: const ResponsiveLayout(
      //   mobileBody: MobileBody(),
      //   desktopBody: DesktopBody(),
      // ),

      /// PC, 平板, 手机 响应布局
      // home: const ResponsiveLayout(
      //     mobileScaffold: MobileScaffold(),
      //     tabletScaffold: TabletScaffold(),
      //     desktopScaffold: DesktopScaffold()),

      // home:  const GoogleNavBar(),
    );
  }
}

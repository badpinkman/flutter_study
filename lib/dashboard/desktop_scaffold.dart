import 'package:flutter/material.dart';
import 'package:flutter_study/constants.dart';
import 'package:flutter_study/utils/my_box.dart';
import 'package:flutter_study/utils/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: myAppBar,
      backgroundColor: myDefaultBackground,
      body: Row(
        children: [
          // 打开抽屉
          myDrawer,
          // 主体布局
          _mainLayout(),
          // 工具栏
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.pinkAccent,
              ))
            ],
          ))
        ],
      ),
    );
  }

  _mainLayout() {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          // 顶部4个box
          AspectRatio(
            aspectRatio: 4,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return const MyBox();
                  }),
            ),
          ),
          // 其他
          Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const MyTile();
                  })),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  String text = '终止';

  get _buttons => Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  FlutterBackgroundService().invoke('setAsForeground');
                },
                child: const Text('前台')),
            ElevatedButton(
                onPressed: () {
                  FlutterBackgroundService().invoke('setAsBackground');
                },
                child: const Text('后台')),
            ElevatedButton(
                onPressed: () async {
                  final service = FlutterBackgroundService();
                  bool isRunning = await service.isRunning();
                  if (isRunning) {
                    service.invoke("stopService");
                  } else {
                    service.startService();
                  }

                  if (!isRunning) {
                    text = "停止服务";
                  } else {
                    text = "启动服务";
                  }
                  setState(() {});
                },
                child: Text(text))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
      ),
      body: _buttons,
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (index) {
              print('点击了索引: $index');
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: '主页',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: '收藏',
              ),
              GButton(
                icon: Icons.search,
                text: '搜索',
              ),
              GButton(
                icon: Icons.settings,
                text: '设置',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

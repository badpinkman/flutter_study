import 'package:flutter/material.dart';

const cityNames = [
  "北京",
  "上海",
  "广州",
  "深圳",
  "杭州",
  "苏州",
  "成都",
  "武汉",
  "郑州",
  "洛阳",
  "厦门",
  "青岛",
  "拉萨",
];

class GridviewPage extends StatelessWidget {
  const GridviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const title = '网格布局';

    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: _buildList(),
        ));
  }

  List<Widget> _buildList() {
    return cityNames
        .asMap()
        .entries
        .map((cityEntry) => _buildItem(cityEntry))
        .toList();
  }

  Widget _buildItem(MapEntry<int, String> entry) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text('${entry.key} ${entry.value}'),
    );
  }
}

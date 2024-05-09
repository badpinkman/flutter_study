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

class HorizontalListPage extends StatelessWidget {
  const HorizontalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('水平列表'),
      ),
      body: SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return cityNames
        .asMap()
        .entries
        .map((cityEntry) => _buildItemEntry(cityEntry))
        .toList();
    // return cityNames.map((city) => _buildItem(city)).toList();
  }

  Widget _buildItem(String city) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.amberAccent, borderRadius: BorderRadius.circular(20)),
      child: Text(city),
    );
  }

  Widget _buildItemEntry(MapEntry<int, String> cityEntry) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.amberAccent, borderRadius: BorderRadius.circular(20)),
      child: Text('${cityEntry.key} ${cityEntry.value}'),
    );
  }
}

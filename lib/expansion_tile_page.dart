import 'package:flutter/material.dart';

const cityNames = {
  "北京市": [
    "东城区",
    "西城区",
    "朝阳区",
    "丰台区",
    "石景山区",
    "海淀区",
    "门头沟区",
    "房山区",
    "通州区",
    "顺义区",
  ],
  "天津市": [
    "和平区",
    "河东区",
    "河西区",
    "南开区",
    "河北区",
    "红桥区",
    "东丽区",
    "西青区",
    "津南区",
  ],
  "石家庄市": [
    "长安区",
    "桥西区",
    "新华区",
    "井陉矿区",
    "裕华区",
    "藁城区",
    "鹿泉区",
    "栾城区",
    "井陉县",
  ],
  "唐山市": [
    "路南区",
    "路北区",
    "古冶区",
    "开平区",
    "丰南区",
    "丰润区",
    "曹妃甸区",
    "滦　县",
  ]
};

class ExpansionTilePage extends StatelessWidget {
  const ExpansionTilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const title = '可展开的列表';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView(
        children: _buildList(),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    for (var key in cityNames.keys) {
      widgets.add(_buildItem(key, cityNames[key]!));
    }
    return widgets;
  }

  Widget _buildItem(String city, List<String> areas) {
    return ExpansionTile(
      title: Text(city),
      children: areas
          .asMap()
          .entries
          .map((areaEntry) => _buildArea(areaEntry))
          .toList(),
    );
  }

  Widget _buildArea(MapEntry<int, String> areaEntry) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text('${areaEntry.key} ${areaEntry.value}'),
            ],
          )),
    );
  }
}

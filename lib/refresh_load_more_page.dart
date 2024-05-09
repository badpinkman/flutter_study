import 'package:flutter/material.dart';

class RefreshLoadMorePage extends StatefulWidget {
  const RefreshLoadMorePage({super.key});

  @override
  State<RefreshLoadMorePage> createState() => _RefreshLoadMorePageState();
}

class _RefreshLoadMorePageState extends State<RefreshLoadMorePage> {
  List<String> provinces = [
    '北京市',
    '天津市',
    '河北省',
    '山西省',
    '内蒙古自治区',
    '辽宁省',
    '吉林省',
    '黑龙江省',
    '上海市',
    '江苏省',
    '浙江省',
    '安徽省',
    '福建省',
    '江西省',
    '山东省',
    '河南省',
    '湖北省',
    '湖南省',
    '广东省',
    '广西壮族自治区',
    '海南省',
    '重庆市',
    '四川省',
    '贵州省',
    '云南省',
    '西藏自治区',
    '陕西省',
    '甘肃省',
    '青海省',
    '宁夏回族自治区',
    '新疆维吾尔自治区',
    '台湾省',
    '香港特别行政区',
    '澳门特别行政区',
  ];

  final ScrollController _scrollController =
      ScrollController(debugLabel: 'debug');

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('当前: ${_scrollController.position.pixels}');
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = '加载更多列表';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),

      /// 使用RefreshIndicator实现下拉刷新
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          controller: _scrollController,
          children: _buildList(),
        ),
      ),
    );
  }

  _buildList() {
    return provinces
        .asMap()
        .entries
        .map((provinceEntry) => _buildItem(provinceEntry))
        .toList();
  }

  Widget _buildItem(MapEntry<int, String> provinceEntry) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text('${provinceEntry.key + 1} ${provinceEntry.value}'),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      provinces = provinces.reversed.toList();
    });
  }

  void _loadMore() async {
    await Future.delayed(const Duration(milliseconds: 200));
    List<String> list = List.from(provinces);
    setState(() {
      list.addAll(provinces);
      provinces = list;
    });
  }
}

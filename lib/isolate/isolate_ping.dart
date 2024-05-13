import 'dart:isolate';

Future<List<int>> calculateListSum(List<int> list) async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    _isolateSum,
    _IsolateData(list, receivePort.sendPort),
  );

  final results = <int>[];
  receivePort.listen((message) {
    print('主线程收到的结果 $message');
    if (message[0] == 0) {
      results.add(message[1]);
    } else if (message[0] == 1) {
      // 通知 Isolate 计算结束
      print('计算完毕: $message 当前results = $results');
      receivePort.close();
      isolate.kill();
    } else {
      print('无效的消息类型: $message');
    }
  });

  return results;
}

void _isolateSum(_IsolateData data) {
  final list = data.list;
  final sendPort = data.sendPort;
  int sum = 0;
  const batchSize = 100;

  for (int i = 0; i < list.length; i += batchSize) {
    final end = i + batchSize > list.length ? list.length : i + batchSize;
    final batch = list.sublist(i, end);
    sum += batch.fold<int>(0, (sum, value) => sum + value);

    // print('向主线程发送结果: $sum');
    sendPort.send([0, sum]);
  }
  sendPort.send([1, 0]);
}

class _IsolateData {
  final List<int> list;
  final SendPort sendPort;

  _IsolateData(this.list, this.sendPort);
}

/// 创建一个单独的线程, 去完成数字的计算
void main() async {
  final myList = List.generate(1000, (index) => index + 1);
  await calculateListSum(myList);
  print('Main 已经执行完毕');
}

import 'dart:isolate';

List<String> generateIpPortList(int total) {
  // Generate IP+Port list
  return List.generate(total, (index) => '192.168.1.$index:1234');
}

List<List<T>> splitList<T>(List<T> list, int numChunks) {
  final chunkSize = (list.length / numChunks).ceil();
  final result = <List<T>>[];

  for (var i = 0; i < list.length; i += chunkSize) {
    final chunk =
        list.sublist(i, i + chunkSize > list.length ? null : i + chunkSize);
    result.add(chunk);
  }

  return result;
}

main() async {
  /// 生成多个IP:PORT
  const int parts = 3;
  const int totalData = 300000;
  final List<String> originalList = generateIpPortList(totalData);
  List<List<dynamic>> dividedList = splitList(originalList, parts);
  print('主线数据已经生成完毕');
  await calculateListSum(dividedList);
  print('主线程已经执行完毕');
}

Future<void> calculateListSum(List<List<dynamic>> dividedList) async {
  final receivePort = ReceivePort();
  final isolates = await Future.wait(
    dividedList.asMap().entries.map(
          (entry) => Isolate.spawn(
              _isolateSum,
              _IsolateData(
                entry.value.cast<String>(),
                receivePort.sendPort,
                entry.key,
              ),
              debugName: 'Isolate-${entry.key}'),
        ),
  );
  int remainingIsolates = isolates.length;
  final results = <String>[];
  receivePort.listen((message) {
    print('主线程收到的结果 $message');
    if (message[0] == 0) {
      results.add(message[1]);
    } else if (message[0] == 1) {
      // 通知 Isolate 计算结束
      remainingIsolates--;
      if (remainingIsolates == 0) {
        // 通知 Isolate 计算结束
        print('计算完毕: $message');
        receivePort.close();
        isolates.forEach((isolate) => isolate.kill());
      }
    } else {
      print('无效的消息类型: $message');
    }
  });

  return;
}

void _isolateSum(_IsolateData data) {
  final list = data.list;
  final sendPort = data.sendPort;
  const batchSize = 100;

  for (int i = 0; i < list.length; i += batchSize) {
    final end = i + batchSize > list.length ? list.length : i + batchSize;
    final batch = list.sublist(i, end);
    sendPort.send([0, '${Isolate.current.debugName} = ${batch.length}']);
  }
  sendPort.send([1, '${Isolate.current.debugName}']);
}

class _IsolateData {
  final List<String> list;
  final SendPort sendPort;
  final int index;
  _IsolateData(this.list, this.sendPort, this.index);
}

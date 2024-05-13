import 'dart:isolate';

import 'package:flutter_study/isolate/ping_data.dart';
import 'package:flutter_study/isolate/tcp_utils.dart';

List<PingData> generateIpPortList(int total) {
  // Generate IP+Port list
  return List.generate(total,
      (index) => PingData(ip: '192.168.1.$index', port: 1234, message: 'ping'));
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
  const int parts = 100;
  const int totalData = 1000;
  final List<PingData> originalList = generateIpPortList(totalData);
  List<List<PingData>> devicesList = splitList<PingData>(originalList, parts);
  print('主线数据已经生成完毕');
  await multiPingAction(devicesList);

  print('主线程已经执行完毕');
}

multiPingAction(List<List<PingData>> devicesList) async {
  var startTime = DateTime.now().millisecondsSinceEpoch;
  final receivePort = ReceivePort();
  final isolateList = await Future.wait(
    devicesList.asMap().entries.map(
          (entry) => Isolate.spawn(
              _isolatePing,
              _IsolateData(
                entry.value.cast<PingData>(),
                receivePort.sendPort,
                entry.key,
              ),
              debugName: 'Isolate-${entry.key + 1}'),
        ),
  );
  int remainingIsolates = isolateList.length;
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
        print('计算完毕: ${results.length}');
        receivePort.close();
        for (var isolate in isolateList) {
          isolate.kill();
        }
      }
    } else {
      print('无效的消息类型: $message');
    }
  });

  return;
}

void _isolatePing(_IsolateData data) async {
  final List<PingData> list = data.list;
  final SendPort sendPort = data.sendPort;
  const int batchSize = 100;

  for (int i = 0; i < list.length; i += batchSize) {
    final end = i + batchSize > list.length ? list.length : i + batchSize;
    final batch = list.sublist(i, end);
    for (int y = 0; y < batch.length; y++) {
      PingData pingData = batch[y];
      final response = await TcpUtils.sendTcpRequest(
          pingData.ip!, pingData.port!, pingData.message!,
          timeout: const Duration(milliseconds: 1000));
      if (response != null) {
        print('ping 响应: $response');
      } else {
        print('ping 响应: No response received');
      }
    }
    sendPort.send([0, '${Isolate.current.debugName} = ${batch.length}']);
  }
  sendPort.send([1, '${Isolate.current.debugName}']);
}

class _IsolateData {
  final List<PingData> list;
  final SendPort sendPort;
  final int index;
  _IsolateData(this.list, this.sendPort, this.index);
}

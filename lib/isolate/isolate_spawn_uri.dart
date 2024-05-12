import 'dart:isolate';

main() {
  start();

  /// 执行一些耗时的任务
  newIsolate();

  init();
}

void newIsolate() async {
  print("创建新线程");
  ReceivePort receive = ReceivePort();
  SendPort send = receive.sendPort;

  /// 创建新线程
  Uri uri = Uri(path: "isolate_spawn_uri_child.dart");
  Isolate childIsolate =
      await Isolate.spawnUri(uri, ['数据1', '数据2', '数据3'], send);

  receive.listen((message) {
    print("主线程收到了消息: ${message[0]}");
    if (message[1] == 2) {
      // 任务完成
      receive.close();
      // kill 新线程, 释放资源
      childIsolate.kill();
      print("新线程已经释放");
    } else if (message[1] == 0) {
      // 开始执行
    } else if (message[1] == 1) {
      // 加载中
    }
  });
}

void start() {
  print("应用启动: ${DateTime.now().millisecondsSinceEpoch}");
}

void init() {
  print("应用初始化");
}

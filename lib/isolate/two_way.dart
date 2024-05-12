import 'dart:isolate';

main() {
  multiThread();
}

void multiThread() async {
  print("multiThread start");
  print("当前线程 ${Isolate.current.debugName}");

  ReceivePort r1 = ReceivePort();
  SendPort s1 = r1.sendPort;

  Isolate.spawn(newThread, s1);
  // var msg = r1.first;
  // print("来自新县城的消息:${msg.toString()} ");

  // r1.listen((message) {
  //   print("来自新线程的消息:${message.toString()} ");
  //   r1.close();
  // });

  SendPort p2 = await r1.first;
  // p2.send("我是住线程");
  var msg = await sendToReceive(p2, '我是主线程');
  print("主线程收到的消息: $msg");
  var msg1 = await sendToReceive(p2, '你是子线程');
  print("主线程收到的消息: $msg1");

  print("multiThread end");
}

void newThread(SendPort p1) async {
  ReceivePort r2 = ReceivePort();
  SendPort s2 = r2.sendPort;

  // List<String> messageList = List.generate(20, (index) => "Hello World $index");
  // for (var msg in messageList) {
  //   print('${Isolate.current.debugName}: $msg');
  // }
  p1.send(s2);

  await for (var msg in r2) {
    var data = msg[0];
    print("新线程收到了来自主线程的消息: $data");
    SendPort replyPort = msg[1];
    replyPort.send("知道你是主线程");
  }
}

/// 发送消息函数
Future sendToReceive(SendPort port, String msg) {
  print('给新线程发消息: $msg');
  ReceivePort response = ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}

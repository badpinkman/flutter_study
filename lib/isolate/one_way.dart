import 'dart:isolate';

main() {
  multiThread();
}

void multiThread() {
  print("multiThread start");
  print("当前线程 ${Isolate.current.debugName}");

  ReceivePort r1 = ReceivePort();
  SendPort s1 = r1.sendPort;

  Isolate.spawn(newThread, s1);
  // var msg = r1.first;
  // print("来自新县城的消息:${msg.toString()} ");

  r1.listen((message) {
    print("来自新线程的消息:${message.toString()} ");
    r1.close();
  });

  print("multiThread end");
}

void newThread(SendPort s1) {
  List<String> messageList = List.generate(20, (index) => "Hello World $index");
  for (var msg in messageList) {
    print('${Isolate.current.debugName}: $msg');
  }
  s1.send('${Isolate.current.debugName} 执行完毕');
}

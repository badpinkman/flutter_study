import 'dart:isolate';

main() {
  multiThread();
}

void multiThread() {
  print("multiThread start");
  print("当前线程 ${Isolate.current.debugName}");
  Isolate.spawn(newThread, List.generate(20, (index) => "Hello World $index"));
  print("multiThread end");
}

void newThread(List<String> messageList) {
  for (var msg in messageList) {
    print('${Isolate.current.debugName}: $msg');
  }
}

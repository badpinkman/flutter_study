import 'dart:io';
import 'dart:isolate';

main(List<String> args, SendPort mainSendPort) {
  print('新线程收到的参数 $args');
  mainSendPort.send(['开始执行异步操作', 0]);
  sleep(const Duration(seconds: 1));
  mainSendPort.send(['加载中', 1]);
  sleep(const Duration(seconds: 1));
  mainSendPort.send(['异步任务完成', 2]);
}

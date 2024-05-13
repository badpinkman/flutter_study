import 'dart:io';

class TcpUtils {
  static Future<String?> sendTcpRequest(
    String ip,
    int port,
    String message, {
    Duration timeout = const Duration(milliseconds: 3000),
  }) async {
    Socket? socket;
    try {
      socket = await Socket.connect(ip, port, timeout: timeout);
      // print('已经连接到 $ip:$port');

      socket.write(message);
      await socket.flush();
      // print('发送消息: $message');

      final buffer = StringBuffer();
      socket.listen(
        (data) {
          buffer.write(String.fromCharCodes(data));
        },
        onDone: () {
          // print('完毕, 关闭连接');
          socket?.destroy();
        },
        onError: (error) {
          // print('TCP 错误: $error');
          socket?.destroy();
        },
        cancelOnError: true,
      );

      // Wait for the response or timeout
      await socket.done.timeout(timeout, onTimeout: () {
        // print('TCP 超时... ');
        buffer.write('TCP超时$ip:$port');
        socket?.destroy();
      });

      return buffer.toString();
    } catch (e) {
      // print('TCP 错误: $e');
      socket?.destroy();
      return null;
    } finally {
      socket?.destroy(); // Ensure the socket is closed
    }
  }
}

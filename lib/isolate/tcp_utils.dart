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
      print('Connected to $ip:$port');

      socket.write(message);
      await socket.flush();
      print('Sent: $message');

      final buffer = StringBuffer();
      socket.listen(
        (data) {
          buffer.write(String.fromCharCodes(data));
        },
        onDone: () {
          print('Server closed connection');
          socket?.destroy();
        },
        onError: (error) {
          print('Error: $error');
          socket?.destroy();
        },
        cancelOnError: true,
      );

      // Wait for the response or timeout
      await socket.done.timeout(timeout, onTimeout: () {
        print('Timeout occurred');
        socket?.destroy();
      });

      return buffer.toString();
    } catch (e) {
      print('Error: $e');
      socket?.destroy();
      return null;
    } finally {
      socket?.destroy(); // Ensure the socket is closed
    }
  }
}

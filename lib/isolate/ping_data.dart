class PingData {
  String? ip;
  int? port;
  String? message;

  PingData({this.ip, this.port, this.message});

  PingData.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    port = json['port'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['port'] = port;
    data['message'] = message;
    return data;
  }
}

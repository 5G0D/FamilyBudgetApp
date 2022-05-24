class RequestException implements Exception {
  String? body;
  int code;
  RequestException(this.code, {this.body});
}

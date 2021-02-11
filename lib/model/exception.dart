class NetworkException implements Exception {
  final String errorExceptionMessage;
  NetworkException({this.errorExceptionMessage = 'Check your network setting'});
}

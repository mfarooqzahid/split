class ServerException implements Exception {
  final String message;
  const ServerException({this.message = 'A server error occurred'});
}

class CacheException implements Exception {
  final String message;
  const CacheException({this.message = 'A cache error occurred'});
}
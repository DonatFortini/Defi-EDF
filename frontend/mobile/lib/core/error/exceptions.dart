class ServerException implements Exception {
  final String message;
  ServerException([this.message = '']);
}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class UnauthorizedException implements Exception {}

class NotFoundException implements Exception {}

class BadRequestException implements Exception {}

class ForbiddenException implements Exception {}

class TimeoutException implements Exception {}

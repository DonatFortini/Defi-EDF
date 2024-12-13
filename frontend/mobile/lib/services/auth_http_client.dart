import 'package:http/http.dart' as http;
import 'auth_service.dart';

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await AuthService.getToken();

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    final response = await _inner.send(request);

    if (response.statusCode == 401) {
      final refreshed = await AuthService.refreshToken();

      if (refreshed) {
        final newToken = await AuthService.getToken();
        final newRequest = await _copyRequest(request);
        if (newToken != null) {
          newRequest.headers['Authorization'] = 'Bearer $newToken';
        }

        return _inner.send(newRequest);
      }
    }

    return response;
  }

  Future<http.BaseRequest> _copyRequest(http.BaseRequest request) async {
    final newRequest = http.Request(request.method, request.url)
      ..headers.addAll(request.headers)
      ..followRedirects = request.followRedirects
      ..persistentConnection = request.persistentConnection;

    if (request is http.Request) {
      newRequest.body = request.body;
    }

    return newRequest;
  }

  @override
  void close() {
    _inner.close();
  }
}

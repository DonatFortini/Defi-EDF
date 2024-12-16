import 'auth_http_client.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

  final AuthHttpClient _client = AuthHttpClient();

  AuthHttpClient get client => _client;
}

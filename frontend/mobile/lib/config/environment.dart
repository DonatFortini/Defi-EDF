// lib/config/environment.dart
enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static Environment _environment = Environment.dev;
  static String _apiUrl = '';

  static void initialize(Environment env) {
    _environment = env;
    switch (_environment) {
      case Environment.dev:
        _apiUrl =
            'https://53a5-2a01-cb16-a-4c37-e08b-faf-990b-93c1.ngrok-free.app';
        break;
      case Environment.staging:
        _apiUrl = 'https://staging-api.edf.fr';
        break;
      case Environment.prod:
        _apiUrl = 'https://api.edf.fr';
        break;
    }
  }

  static String get apiUrl => _apiUrl;
  static String get dashboardEndpoint => '/api/public/dashboard';
  static String get dashboardUrl => '$apiUrl$dashboardEndpoint';
}

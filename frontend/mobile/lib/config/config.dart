// lib/config/config.dart
enum Environment { dev, staging, prod }

class EnvironmentConfig {
  static Environment _environment = Environment.dev;
  static String _apiUrl = '';

  static void initialize(Environment env) {
    _environment = env;
    switch (_environment) {
      case Environment.dev:
        _apiUrl =
            'https://9a00-2a01-cb16-204b-b98-ac62-7a9-19f1-1eb0.ngrok-free.app';
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

  static String historiqueContactEndpoint(int userId) =>
      '/api/public/historique/$userId';
  static String calculationCO2Endpoint(int propulsionId) =>
      '/api/public/calculation/$propulsionId';
  static String communauteArticleEndpoint(int articleId) =>
      '/api/public/communaute/$articleId';

  static String get loginEndpoint => '/api/public/login';
  static String get plateEndpoint => '/api/upload/plate-number';
  static String get mileageEndpoint => '/api/upload/mileage';
  static String get resaEndpoint => '';

  static String get dashboardUrl => '$apiUrl$dashboardEndpoint';
  static String getHistoriqueContactUrl(int userId) =>
      '$apiUrl${historiqueContactEndpoint(userId)}';

  static String getCalculationCO2Url(int propulsionId) =>
      '$apiUrl${calculationCO2Endpoint(propulsionId)}';

  static String getCommunauteArticleUrl(int articleId) =>
      '$apiUrl${communauteArticleEndpoint(articleId)}';

  static String getLoginUrl(String email, String password) =>
      '$apiUrl$loginEndpoint';

  static String getSendPlateUrl() => '$apiUrl$plateEndpoint';
  static String getSendMileageUrl() => '$apiUrl$mileageEndpoint';
}

class ApiConfig {
  static const String baseUrl =
      'https://17ab-2a01-cb16-a-4c37-cfbf-6ebc-1b63-60bc.ngrok-free.app';
  static const String dashboardEndpoint = '/api/public/dashboard';

  // URL complète pour le dashboard
  static String get dashboardUrl => '$baseUrl$dashboardEndpoint';
}

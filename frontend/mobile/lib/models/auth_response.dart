class AuthResponse {
  final String? token;
  final String? refreshToken;
  final String? error;

  AuthResponse({this.token, this.refreshToken, this.error});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      refreshToken: json['refresh_token'],
      error: json['error'],
    );
  }
}

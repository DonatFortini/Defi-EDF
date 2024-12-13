class AuthResponse {
  final String? token;
  final String? refreshToken;
  final String? error;
  final String? email;
  final String? idUtilisateur;
  final String? nomUtilisateur;

  AuthResponse(
      {this.token,
      this.refreshToken,
      this.error,
      this.email,
      this.idUtilisateur,
      this.nomUtilisateur});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        token: json['token'],
        refreshToken: json['refresh_token'],
        error: json['error'],
        email: json['email'],
        idUtilisateur: json['id_utilisateur'],
        nomUtilisateur: json['nom_utilisateur']);
  }
}

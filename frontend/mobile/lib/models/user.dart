class User {
  final int id;
  final String email;
  final String nomUtilisateur;
  final String idUtilisateur;
  // Ajoutez d'autres champs selon vos besoins

  User(
      {required this.id,
      required this.email,
      required this.nomUtilisateur,
      required this.idUtilisateur});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: int.parse(json['token']
            .toString()
            .split('_')
            .last), // Extraire l'ID du fake_token
        email: json['email'],
        nomUtilisateur: json['nom_utilisateur'],
        idUtilisateur: json['id_utilisateur']);
  }
}

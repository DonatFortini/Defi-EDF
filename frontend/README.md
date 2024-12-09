# Frontend README

## Structure du Projet

La partie frontend de ce projet est organisée comme suit :

```
lib
├── core
│   ├── platform_aware.dart
│   └── responsive_layout.dart
├── main.dart
├── platform
├── screens
│   ├── home_screen.dart
│   ├── mobile_home.dart
│   └── web_home.dart
├── services
│   └── data_services.dart
└── widgets
    ├── adaptative_widget.dart
    └── responsive_builder.dart
```

### Dossiers et Fichiers

- **core**: Contient les fonctionnalités de base telles que la prise en compte des plateformes et la gestion des mises en page réactives.

  - `platform_aware.dart`: Gère la logique spécifique à la plateforme.
  - `responsive_layout.dart`: Gère les configurations de mise en page réactive.

- **main.dart**: Le point d'entrée de l'application.

- **platform**: Contient les implémentations spécifiques à la plateforme (actuellement vide).

- **screens**: Contient les différentes écrans de l'application.

  - `home_screen.dart`: L'écran d'accueil principal.
  - `mobile_home.dart`: Mise en page de l'écran d'accueil pour les appareils mobiles.
  - `web_home.dart`: Mise en page de l'écran d'accueil pour le web.

- **services**: Contient les classes de service pour la gestion des données.

  - `data_services.dart`: Gère la récupération et le traitement des données.

- **widgets**: Contient des widgets réutilisables.
  - `adaptative_widget.dart`: Un widget qui s'adapte aux différentes plateformes.
  - `responsive_builder.dart`: Un widget constructeur pour le design réactif.

## Pour Commencer

Pour commencer avec la partie frontend de ce projet, suivez ces étapes :

1. **Installer les Dépendances** :

   ```bash
   flutter pub get
   ```

2. **Lancer l'Application** :
   web :
   ```bash
   flutter run -d chrome
   ```
   android :
   ```bash
   flutter run -d android
   ```
   ios :
   ```bash
   flutter run -d ios
   ```

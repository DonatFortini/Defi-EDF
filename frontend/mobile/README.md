# Frontend README

## Structure du Projet

La partie frontend de ce projet est organisée comme suit :

```
lib
├── core
│   ├── providers
│   ├── platform_aware.dart
│   └── responsive_layout.dart
├── main.dart
├── layout
├── screens
│
├── services
│   └── data_services.dart
└── widgets
```

### Dossiers et Fichiers

- **core**: Contient les fonctionnalités de base telles que la prise en compte des plateformes et la gestion des mises en page réactives.

-**providers**:

- **main.dart**: Le point d'entrée de l'application.

- **layout**: Disposition des différent widgets sur les pages

- **screens**: Contient les différentes écrans de l'application.

- **services**: Contient les classes de service pour la gestion des données.

- **widgets**: Contient des widgets réutilisables.

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

# Backend

Ce dossier contient les différentes parties du backend de notre projet.

## Structure du dossier

```
backend
├── apis
│   └── readme.md
├── core
│   └── readme.md
├── endpoint
│   └── readme.md
└── readme.md
```

### `apis`

Le dossier `apis` contient les API appelées par le frontend pour interagir avec le backend. Vous trouverez plus de détails dans le fichier `apis/readme.md`.

### `core`

Le dossier `core` contient les différents modèles d'IA et les calculs serveur. Vous trouverez plus de détails dans le fichier `core/readme.md`.

### `endpoint`

Le dossier `endpoint` contient le serveur et les routes flask

### Instructions pour exécuter Docker

Pour construire l'image Docker du backend, exécutez la commande suivante :

```sh
docker build -t edf-back-image .
```

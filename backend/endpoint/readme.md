# Endpoint

Ce répertoire contient le backend de l'application Defi-EDF, développé en utilisant Flask et protégée avec [FASTAPI](../fastapi/readme.md). Le but de cet endpoint est de fournir des services et des routes pour l'application, incluant des calculs, des prédictions et des interactions avec la base de données.

## Structure du répertoire

```
endpoint
├── app.py
├── __init__.py
├── readme.md
├── routes.py
└── services
    ├── calculation.py
    ├── CNNPrediction.py
    ├── db
    │   ├── dbconn.py
    │   ├── disaster.py
    │   ├── export.py
    │   ├── fleet_management.py
    │   ├── __init__.py
    │   ├── maintenance.py
    │   ├── reservation.py
    │   └── user.py
    └── __init__.py
```

### Description des fichiers

- `app.py` : Point d'entrée principal de l'application Flask.
- `routes.py` : Définit les routes de l'application Flask.

### Description des services

- `services/calculation.py` : Contient les fonctions de calcul de consomations (Co2, Diesel, etc...)
- `services/CNNPrediction.py` : Implémente les prédictions utilisant les modèles de `core`. Pour plus de détails, consultez le [readme de backend/core](../core/readme.md).
- `services/db` : Répertoire contenant les modules de gestion de la base de données.
  - `dbconn.py` : Gère la connexion à la base de données.
  - `disaster.py` : Module pour la gestion des données de catastrophes.
  - `export.py` : Fournit des fonctionnalités d'exportation de données.
  - `fleet_management.py` : Gère les données de gestion de flotte.
  - `maintenance.py` : Gère les données de maintenance.
  - `reservation.py` : Gère les données de réservation.
  - `user.py` : Gère les données des utilisateurs.

## Commandes

Pour lancer l'application Flask, utilisez les commandes suivantes :

```bash
export FLASK_APP=app.py
export FLASK_ENV=development
flask run
```

Ces commandes configurent l'application Flask et la démarrent en mode développement.

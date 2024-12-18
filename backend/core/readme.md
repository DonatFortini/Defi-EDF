# Core

Le dossier `core` contient les modeles principaux nécessaires au fonctionnement au scan de plaques et de tableau de bords. Voici une description de son contenu :

## Structure du Dossier

```
core
├── datasets
│   ├── CV_immatriculationS
│   └── Tableau_de_Bord
├── models
│   ├── baseModel.py
│   ├── mileageModel.py
│   ├── plateModel.py
│   ├── saved/
│   └── trainTests.py
├── readme.md
└── utils
    └── manip_image.py
```

## Description des Sous-Dossiers et Fichiers

### datasets

Ce dossier contient les jeux de données utilisés par les modèles. Il inclut :

- `CV_immatriculation` : Dossier contenant des données de plaques d'immatriculation
- `Tableau_de_Bord` : Dossier avec des données pour le tableau de bord.

### models

Ce dossier contient les modèles de machine learning et les scripts associés :

- `baseModel.py` : Script de base pour les modèles.
- `mileageModel.py` : Modèle pour prédire le kilométrage.
- `plateModel.py` : Modèle pour la reconnaissance des plaques d'immatriculation.
- `saved` : Dossier pour les modèles sauvegardés.
- `trainTests.py` : Script pour les tests d'entraînement des modèles.

### utils

Ce dossier contient des utilitaires pour le projet :

- `manip_image.py` : Script pour la manipulation des images.

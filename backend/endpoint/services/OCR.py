import sys
import os

# Obtenir le chemin absolu du dossier racine du projet (backend)
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))
sys.path.append(project_root)

# Maintenant nous pouvons importer le module
from core.model.model import Model

def getPlateNumber(filepath: str) -> str:
    model = Model()
    return model.predict(filepath, 0)

def getMileage(filepath: str) -> str:
    model = Model()
    return model.predict(filepath, 1)
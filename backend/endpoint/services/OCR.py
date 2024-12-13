import sys
import os

project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))
sys.path.append(project_root)

from core.model.model import Model

def getPlateNumber(filepath: str) -> str:
    model = Model()
    return model.predict(filepath, 0)

def getMileage(filepath: str) -> str:
    model = Model()
    return model.predict(filepath, 1)
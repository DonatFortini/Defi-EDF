from torch import load as tload
from sys import path as spath
from os import path as ospath

project_root = ospath.abspath(
    ospath.join(ospath.dirname(__file__), '../..'))
spath.append(project_root)


def getPlateNumber(filepath: str) -> str:
    model = tload('core/models/saved/plateModel.pth')
    return model.predict(filepath)


def getMileage(filepath: str) -> str:
    model = tload('core/models/saved/mileageModel.pth')
    return model.predict(filepath)

from core.model.model import Model


def get_plate_number(filepath: str) -> str:
    model = Model()
    return model.predict(filepath, 0)

def get_mileage(filepath: str) -> str:
    model = Model()
    return model.predict(filepath, 1)
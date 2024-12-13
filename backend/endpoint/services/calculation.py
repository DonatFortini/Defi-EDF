def get_CO2_estimation(distance: float) -> str:
    return str(distance * 0.12)

def get_electricity_cost_estimation(distance: float) -> str:
    return str(distance * 0.05)

def get_gasoline_cost_estimation(distance: float) -> str:
    return str(distance * 0.07)

def get_diesel_cost_estimation(distance: float) -> str:
    return str(distance * 0.06)

def electrical_consumption_estimation(distance: float) -> str:
    return str(distance * 0.2)

def gasoline_consumption_estimation(distance: float) -> str:
    return str(distance * 0.1)

def diesel_consumption_estimation(distance: float) -> str:
    return str(distance * 0.15)

from app import app
from services.db.fleet_management import get_fleet, get_fleet_dashboard
from services.db.user import get_users, get_user_by_id, get_user_name_by_id
from services.OCR import getPlateNumber, getMileage
from services.calculation import get_CO2_estimation, get_electricity_cost_estimation, get_gasoline_cost_estimation, get_diesel_cost_estimation, electrical_consumption_estimation, gasoline_consumption_estimation, diesel_consumption_estimation


@app.route('/', methods=['GET'])
def hello():
    return 'Hello, World!'

# ---------------------------------------------Fleet---------------------------------------------


@app.route('/Fleet/', methods=['GET'])
def getFleet():
    print(get_fleet())
    return get_fleet()


@app.route('/Fleet/dashboard', methods=['GET'])
def getFleetDashboard():
    return get_fleet_dashboard()


# ---------------------------------------------User---------------------------------------------

@app.route('/Users/', methods=['GET'])
def getUsers():
    return get_users()


@app.route('/User/<int:id>', methods=['GET'])
def getUserById(id):
    return get_user_by_id(id)


@app.route('/User/<int:id>/Name', methods=['GET'])
def getUserNameById(id):
    return get_user_name_by_id(id)

# ---------------------------------------------Renting-----------------------------------------


@app.route('/Renting/', methods=['GET'])
# ---------------------------------------------OCR---------------------------------------------
@app.route('/OCR/PlateNumber', methods=['POST'])
def getPlateNumber(filepath: str):
    return getPlateNumber(filepath)


@app.route('/OCR/Mileage', methods=['POST'])
def getMileage(filepath: str):
    return getMileage(filepath)

# ---------------------------------------------Maintenance-------------------------------------


# ---------------------------------------------calculation-------------------------------------

@app.route('/Calculation/Co2/<float:distance>', methods=['GET'])
def getCo2Estimation(distance: float):
    return get_CO2_estimation(distance)


@app.route('/Calculation/ElectricityCost/<float:distance>', methods=['GET'])
def getElectricityCostEstimation(distance: float):
    return get_electricity_cost_estimation(distance)


@app.route('/Calculation/GasolineCost/<float:distance>', methods=['GET'])
def getGasolineCostEstimation(distance: float):
    return get_gasoline_cost_estimation(distance)


@app.route('/Calculation/DieselCost/<float:distance>', methods=['GET'])
def getDieselCostEstimation(distance: float):
    return get_diesel_cost_estimation(distance)


@app.route('/Calculation/ElectricalConsumption/<float:distance>', methods=['GET'])
def getElectricalConsumptionEstimation(distance: float):
    return electrical_consumption_estimation(distance)


@app.route('/Calculation/GasolineConsumption/<float:distance>', methods=['GET'])
def getGasolineConsumptionEstimation(distance: float):
    return gasoline_consumption_estimation(distance)


@app.route('/Calculation/DieselConsumption/<float:distance>', methods=['GET'])
def getDieselConsumptionEstimation(distance: float):
    return diesel_consumption_estimation(distance)

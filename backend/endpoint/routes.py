from flask import request, jsonify, make_response
from werkzeug.exceptions import BadRequest, NotFound
from app import app
from services.db.export import export_vehicle_mileage_to_csv, export_all_reservations_to_csv
from services.db.fleet_management import get_fleet, get_fleet_dashboard
from services.db.user import authenticate_user, get_user_info, get_users, get_user_by_id, get_user_name_by_id, user_exists, validate_user
from services.OCR import getPlateNumber, getMileage
from services.calculation import (
    get_CO2_estimation, get_electricity_cost_estimation,
    get_gasoline_cost_estimation, get_diesel_cost_estimation,
    electrical_consumption_estimation, gasoline_consumption_estimation,
    diesel_consumption_estimation
)
from services.db.reservation import does_user_have_reservation, get_reservations_for_user, recommend_car, rent_vehicle
from services.db.maintenance import get_mileage_for_vehicle, maintenance_needed, update_mileage_for_vehicle
import datetime
import os


def validate_date(date_string):
    """
    Valider et analyser une chaîne de date.

    Args:
        date_string (str): Chaîne de date à valider

    Returns:
        datetime.date: Date analysée

    Raises:
        ValueError: Si la date est invalide
    """
    try:
        return datetime.datetime.strptime(date_string, '%Y-%m-%d').date()
    except ValueError:
        raise BadRequest("Format de date invalide. Utilisez YYYY-MM-DD.")


def validate_positive_number(value, param_name):
    """
    Valider qu'un nombre est positif.

    Args:
        value (int ou float): Nombre à valider
        param_name (str): Nom du paramètre pour le message d'erreur

    Raises:
        BadRequest: Si la valeur n'est pas un nombre positif
    """
    try:
        numeric_value = float(value)
        if numeric_value <= 0:
            raise BadRequest(f"{param_name} doit être un nombre positif.")
        return numeric_value
    except ValueError:
        raise BadRequest(f"{param_name} invalide. Doit être un nombre.")


@app.route('/', methods=['GET'])
def hello():
    """Point de contrôle de santé."""
    return make_response(jsonify({"message": "Hello, World!"}), 200)


# ---------------------------------------------Flotte---------------------------------------------


@app.route('/Fleet/', methods=['GET'])
def get_fleet_route():
    """Récupérer les informations de la flotte."""
    return get_fleet()


@app.route('/Fleet/dashboard', methods=['GET'])
def get_fleet_dashboard_route():
    """Récupérer le tableau de bord de la flotte."""
    return get_fleet_dashboard()


# ---------------------------------------------Utilisateur---------------------------------------------


@app.route('/Users/', methods=['GET'])
def get_users_route():
    """Récupérer tous les utilisateurs."""
    return get_users()


@app.route('/User/<int:id>', methods=['GET'])
def get_user_by_id_route(id):
    """Récupérer un utilisateur par ID."""
    if id <= 0:
        raise BadRequest("ID utilisateur invalide")
    return get_user_by_id(id)

@app.route('/User/<int:id>/Info', methods=['GET'])
def get_user_info_route(id):
    """Récupérer les informations d'un utilisateur par ID."""
    if id <= 0:
        raise BadRequest("ID utilisateur invalide")
    return get_user_info(id)


@app.route('/User/<int:id>/Name', methods=['GET'])
def get_user_name_by_id_route(id):
    """Récupérer le nom d'un utilisateur par ID."""
    if id <= 0:
        raise BadRequest("ID utilisateur invalide")
    return get_user_name_by_id(id)


@app.route('/User/Exists/<int:id>', methods=['GET'])
def user_exists_route(id: int):
    """Vérifier si l'utilisateur existe."""
    if id <= 0:
        raise BadRequest("ID utilisateur invalide")
    return user_exists(id)


@app.route('/User/Validate', methods=['POST'])
def validate_user_route():
    """Valider les informations d'identification de l'utilisateur."""
    data = request.get_json()

    if not data:
        raise BadRequest("Aucune donnée fournie")

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        raise BadRequest("Email et mot de passe sont requis")

    return validate_user(email, password)

@app.route('/auth/login', methods=['POST'])
def login():
    try:
        data = request.json
        if not data or 'email' not in data or 'password' not in data:
            return jsonify({"error": "Email et mot de passe requis"}), 400
            
        print(data)

        result = authenticate_user(data['email'], data['password'])
        
        if result["success"]:
            return jsonify(result["data"])
        else:
            return jsonify({"error": result["error"]}), 401
            
    except Exception as e:
        print(f"Erreur lors de la connexion: {str(e)}")
        return jsonify({"error": "Erreur serveur interne"}), 500

# ---------------------------------------------Réservation--------------------------------------


@app.route('/Reservation/<int:userId>', methods=['GET'])
def get_reservations_for_user_route(userId: int):
    """Récupérer les réservations pour un utilisateur spécifique."""
    if userId <= 0:
        raise BadRequest("ID utilisateur invalide")
    return get_reservations_for_user(userId)


@app.route('/Reservation/Rent/<int:userId>/<int:vehicleId>/<start_date>/<end_date>/<int:nb_places_reservees>', methods=['POST'])
def rent_vehicle_route(userId: int, vehicleId: int, start_date: str, end_date: str, nb_places_reservees: int):
    """Louer un véhicule."""
    # Valider les entrées
    if userId <= 0:
        raise BadRequest("ID utilisateur invalide")
    if vehicleId <= 0:
        raise BadRequest("ID véhicule invalide")
    if nb_places_reservees <= 0:
        raise BadRequest("Le nombre de places réservées doit être positif")

    start = validate_date(start_date)
    end = validate_date(end_date)

    if start > end:
        raise BadRequest(
            "La date de début doit être avant ou égale à la date de fin")

    return rent_vehicle(userId, vehicleId, start_date, end_date, nb_places_reservees)

@app.route('/Reservation/Check/<int:userId>', methods=['GET'])
def does_user_have_reservation_route(userId: int):
    """Vérifier si l'utilisateur a une réservation pour aujourd'hui."""
    if userId <= 0:
        raise BadRequest("ID utilisateur invalide")
    return does_user_have_reservation(userId)


@app.route('/Reservation/CarList/<float:distance>', methods=['GET'])
def recommend_car_route(distance: float):
    """Recommander une liste de voitures pour une distance donnée."""
    distance = validate_positive_number(distance, "Distance")
    return recommend_car(distance)


# ---------------------------------------------OCR---------------------------------------------


@app.route('/OCR/PlateNumber', methods=['POST'])
def get_plate_number_route():
    """Extraire le numéro de plaque à partir du fichier téléchargé."""
    if 'file' not in request.files:
        raise BadRequest("Aucun fichier téléchargé")

    file = request.files['file']
    if file.filename == '':
        raise BadRequest("Aucun fichier sélectionné")

    filepath = os.path.join('/tmp', file.filename)
    file.save(filepath)

    try:
        return getPlateNumber(filepath)
    finally:
        os.remove(filepath)


@app.route('/OCR/Mileage', methods=['POST'])
def get_mileage_route():
    """Extraire le kilométrage à partir du fichier téléchargé."""
    if 'file' not in request.files:
        raise BadRequest("Aucun fichier téléchargé")

    file = request.files['file']
    if file.filename == '':
        raise BadRequest("Aucun fichier sélectionné")

    filepath = os.path.join('/tmp', file.filename)
    file.save(filepath)

    try:
        return getMileage(filepath)
    finally:
        os.remove(filepath)


# ---------------------------------------------Maintenance-------------------------------------


@app.route('/Maintenance/Mileage/<int:vehicle_id>', methods=['GET'])
def get_mileage_for_vehicle_route(vehicle_id: int):
    """Récupérer le kilométrage pour un véhicule spécifique."""
    if vehicle_id <= 0:
        raise BadRequest("ID véhicule invalide")
    return get_mileage_for_vehicle(vehicle_id)

@app.route('/Maintenance/Mileage/<int:vehicle_id>/<int:mileage>/<source>', methods=['POST'])
def updateMileageForVehicle(vehicle_id: int, mileage: int, source: str):
    return update_mileage_for_vehicle(vehicle_id, mileage, source)


@app.route('/Maintenance/Needed/<vehicle_type>/<int:mileage>', methods=['GET'])
def maintenance_needed_route(vehicle_type: str, mileage: int):
    """Vérifier si un entretien est nécessaire pour un type de véhicule et un kilométrage donné."""
    if mileage <= 0:
        raise BadRequest("Le kilométrage doit être positif")

    return maintenance_needed(vehicle_type, mileage)

# ---------------------------------------------Calcul-------------------------------------


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


# ---------------------------------------------Export--------------------------------------


@app.route('/Export/VehicleMileage', methods=['GET'])
def export_vehicle_mileage_route():
    """Exporter le kilométrage des véhicules en CSV en utilisant le répertoire par défaut."""
    return export_vehicle_mileage_to_csv()


@app.route('/Export/VehicleMileage/<output_directory>', methods=['GET'])
def export_vehicle_mileage_with_directory_route(output_directory: str):
    """Exporter le kilométrage des véhicules en CSV avec le répertoire spécifié."""
    if not output_directory:
        raise BadRequest("Le répertoire de sortie ne peut pas être vide")

    # Valider le chemin du répertoire
    try:
        os.makedirs(output_directory, exist_ok=True)
    except Exception as e:
        raise BadRequest(f"Répertoire de sortie invalide: {str(e)}")

    return export_vehicle_mileage_to_csv(output_directory)


@app.route('/Export/Reservations', methods=['GET'])
def export_reservations_route():
    """Exporter les réservations en CSV en utilisant le répertoire par défaut."""
    return export_all_reservations_to_csv()


@app.route('/Export/Reservations/<output_directory>', methods=['GET'])
def export_reservations_with_directory_route(output_directory: str):
    """Exporter les réservations en CSV avec le répertoire spécifié."""
    if not output_directory:
        raise BadRequest("Le répertoire de sortie ne peut pas être vide")

    # Valider le chemin du répertoire
    try:
        os.makedirs(output_directory, exist_ok=True)
    except Exception as e:
        raise BadRequest(f"Répertoire de sortie invalide: {str(e)}")

    return export_all_reservations_to_csv(output_directory)


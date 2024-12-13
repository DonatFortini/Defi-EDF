from .dbconn import dbpool
import datetime as Datetime


def get_reservations_for_user(user_id: int)-> list:
    try:
        result = dbpool.query(
            "SELECT * FROM reservation WHERE id_utilisateur = %s", (user_id,))
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e


def rent_vehicle(user_id: int, vehicle_id: int, start_date: Datetime.date, end_date: Datetime.time , nb_places_reservees: int)-> bool:
    try:
        dbpool.query("INSERT INTO reservation (id_reservation,id_utilisateur, id_vehicule, date_debut, date_fin,nb_places_reservees) VALUES (%s, %s, %s, %s)",
                     (user_id, vehicle_id, start_date, end_date))
        return True
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
def does_user_have_reservation(user_id: int) -> bool:
    try:
        today = Datetime.date.today()
        result = dbpool.query(
            "SELECT id_vehicule FROM reservation WHERE id_utilisateur = %s AND date_debut = %s", (user_id, today))
        return len(result) > 0
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
from datetime import datetime

def recommend_car(distance: float):
    try:
        # Current date for filtering reservations
        current_date = datetime.now().date()
        
        result = dbpool.query("""
            SELECT 
                vehicule.id_vehicule, autonomie_theorique, releve_km, nom_modele, immatriculation, 
                type_propulsion, nb_places, reservation.id_reservation, reservation.date_debut, reservation.date_fin
            FROM vehicule 
            JOIN modele ON vehicule.id_modele = modele.id_modele
            JOIN propulsion ON modele.id_propulsion = propulsion.id_propulsion
            JOIN releve_km ON vehicule.id_vehicule = releve_km.id_vehicule
            LEFT JOIN reservation ON vehicule.id_vehicule = reservation.id_vehicule
        """)
        
        # Filter out cars currently in reservation
        available_cars = [
            car for car in result 
            if not (
                car[7] and 
                car[8] <= current_date <= car[9]
            )
        ]
        
        # Filter electric cars meeting the autonomy condition
        electric_cars = [car for car in available_cars if car[5] == 'electric' and car[1] >= 2 * distance]
        
        # Filter other cars
        other_cars = [car for car in available_cars if car[5] != 'electric' or car[1] < 2 * distance]
        
        # Sort electric cars by autonomie_theorique in descending order
        electric_cars.sort(key=lambda x: x[1], reverse=True)
        
        # Sort other cars by the difference between their autonomie_theorique and 2 * distance in ascending order
        other_cars.sort(key=lambda x: 2 * distance - x[1])
        
        # Prepare the response dictionary
        response = []
        for car in electric_cars + other_cars:
            is_reserved = bool(car[7])
            response.append({
                "id_vehicule": car[0],
                "nom_modele": car[3],
                "autonomie_theorique": car[1],
                "is_electric": car[5] == 'electric',
                "is_reserved": is_reserved,
                "releve_km": car[2],
                "immatriculation": car[4],
                "nb_places": car[6],
                "priority": car[5] == 'electric' and car[1] >= 2 * distance
            })
        return response
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e





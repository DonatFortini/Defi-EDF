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
    
def recommend_car(distance: float):
    try:
        result = dbpool.query("SELECT id_vehicule, autonomie, capacite, id_reservation, releve_km, id_modele, id_site, immatriculation, taille_batterie, conso_kw_100 FROM vehicule")
        electric_cars = [car for car in result if car['autonomie'] >= 2 * distance]
        other_cars = [car for car in result if car['autonomie'] < 2 * distance]

        # Sort electric cars by autonomy in descending order
        electric_cars.sort(key=lambda x: x['autonomie'], reverse=True)

        # Sort other cars by the difference between their autonomy and 2 * distance in ascending order
        other_cars.sort(key=lambda x: 2 * distance - x['autonomie'])

        # Prepare the response dictionary
        response = []
        for car in electric_cars + other_cars:
            is_reserved = bool(car['id_reservation'])
            response.append({
                "id_modele": car['id_modele'],
                "autonomie": car['autonomie'],
                "is_electric": car['autonomie'] >= 2 * distance,
                "is_reserved": is_reserved,
                "releve_km": car['releve_km'],
                "id_site": car['id_site'],
                "immatriculation": car['immatriculation'],
                "taille_batterie": car['taille_batterie'],
                "conso_kw_100": car['conso_kw_100']
            })
        return response
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e




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




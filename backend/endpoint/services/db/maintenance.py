from .dbconn import dbpool
import datetime as Datetime


def get_mileage_for_vehicle(vehicle_id: int) -> int:
    try:
        result = dbpool.query(
            "SELECT releve_km FROM releve_km WHERE id_vehicule = %s", (vehicle_id,))
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e


def update_mileage_for_vehicle(plate_number: str, mileage: int, source: str) -> bool:
    try:
        dbpool.query("UPDATE releve_km SET releve_km = %s and date_releve=% source_releve=% WHERE immatriculation = %s",
                     (mileage, Datetime.datetime, source, plate_number))
        return True
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e


def maintenance_needed(vehicle_type: str, mileage: int) -> bool:
    rate = 15000 if vehicle_type == "thermique" else 25000 if vehicle_type == "hybride" else 20000
    remaining_mileage = rate - (mileage % rate)
    return remaining_mileage
   

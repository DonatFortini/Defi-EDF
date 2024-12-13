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


def update_mileage_for_vehicle(vehicle_id: int, mileage: int, source: str) -> bool:
    try:
        dbpool.query("UPDATE releve_km SET releve_km = %s and date_releve=% source_releve=% WHERE id_vehicule = %s",
                     (mileage, Datetime.datetime, source, vehicle_id))
        return True
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e

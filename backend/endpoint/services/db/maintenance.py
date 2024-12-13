from .dbconn import dbpool

def get_mileage_for_vehicle(vehicle_id: int):
    try:
        result = dbpool.query("SELECT * FROM mileage WHERE id_vehicule = %s", (vehicle_id,))
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    
def update_mileage_for_vehicle(vehicle_id: int, mileage: int):
    try:
        dbpool.query("UPDATE mileage SET kilometrage = %s WHERE id_vehicule = %s", (mileage, vehicle_id))
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
    

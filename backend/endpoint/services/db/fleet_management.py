from .dbconn import dbpool


def get_fleet():
    try:
        result = dbpool.query("SELECT * FROM vehicule")
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e


def get_fleet_by_id(id: int):
    try:
        result = dbpool.query("SELECT * FROM vehicule WHERE id = %s", (id,))
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e


def get_fleet_by_type():
    try:
        result = dbpool.query(
            "SELECT id FROM vehicule v LEFT JOIN modele m ON v.id_modele = m.id_modele")
        return result
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e


def get_fleet_dashboard():
    electric, thermic, leased, free = "", "", "", ""
    req_type = "SELECT COUNT(*) FROM vehicule v INNER JOIN modele m ON v.id_modele = m.id_modele INNER JOIN propulsion p ON m.id_propulsion = p.id_propulsion"
    req_leased = "SELECT COUNT(*) FROM vehicule WHERE leased = TRUE"
    req_free = "SELECT COUNT(*) FROM vehicule WHERE leased = FALSE"
    try:
        result = dbpool.query(req_type)
        electric = result[0][0]
        thermic = result[1][0] + result[2][0]

        result = dbpool.query(req_leased)
        leased = result[0][0]

        result = dbpool.query(req_free)
        free = result[0][0]
        
        return electric, thermic, leased, free
    except Exception as e:
        dbpool.query("ROLLBACK")
        raise e
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
    try:
        # Requête pour compter les véhicules par type de propulsion
        req_type = """
            SELECT p.id_propulsion, COUNT(*)
            FROM vehicule v 
            INNER JOIN modele m ON v.id_modele = m.id_modele 
            INNER JOIN propulsion p ON m.id_propulsion = p.id_propulsion
            GROUP BY p.id_propulsion
        """

        # Requête pour les véhicules actuellement loués
        req_leased = """
            SELECT COUNT(*) 
            FROM vehicule v 
            INNER JOIN reservation r ON v.id_vehicule = r.id_vehicule 
            WHERE NOW() BETWEEN date_debut AND date_fin
        """

        # Requête pour le total des véhicules
        req_total = "SELECT COUNT(*) FROM vehicule"

        # Initialisation des compteurs
        electric = 0
        thermic = 0

        # Récupération des véhicules par type
        result = dbpool.query(req_type)
        for row in result:
            if row[0] == 1:  # Électrique
                electric = row[1]
            elif row[0] in (2, 3):  # Thermique ou Hybride
                thermic += row[1]

        # Récupération des véhicules loués
        result = dbpool.query(req_leased)
        leased = result[0][0]

        # Calcul des véhicules libres
        result = dbpool.query(req_total)
        total = result[0][0]
        free = total - leased

        return {
            "propulsion": {
                "electric": electric, "thermic": thermic
            },
            "dispo": {
                "leased": leased, "free": free
            }
        }

    except Exception as e:
        dbpool.execute("ROLLBACK")  # Utiliser execute au lieu de query
        raise e

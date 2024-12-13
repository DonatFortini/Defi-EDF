import csv
import os
from datetime import datetime
from .dbconn import dbpool


def create_output_directory(output_directory: str):
    os.makedirs(output_directory, exist_ok=True)


def generate_filename(output_directory: str, prefix: str) -> str:
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    return os.path.join(output_directory, f'{prefix}_{timestamp}.csv')


def write_to_csv(filename: str, fieldnames: list, rows: list):
    with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)


def export_all_reservations_to_csv(output_directory: str = 'exports') -> str:
    """
    Export all reservations for all users to a CSV file.

    Args:
        output_directory (str): Directory to save the CSV file. Defaults to 'exports'.

    Returns:
        str: Full path to the generated CSV file
    """
    try:
        create_output_directory(output_directory)

        result = dbpool.query(
            """
            SELECT 
                r.id_reservation, 
                r.id_utilisateur, 
                r.id_vehicule, 
                r.date_debut, 
                r.date_fin, 
                r.nb_places_reservees,
                u.nom AS utilisateur_nom,
                u.prenom AS utilisateur_prenom,
                v.marque AS vehicule_marque,
                v.modele AS vehicule_modele
            FROM 
                reservation r
            LEFT JOIN 
                utilisateur u ON r.id_utilisateur = u.id_utilisateur
            LEFT JOIN 
                vehicule v ON r.id_vehicule = v.id_vehicule
            """
        )

        filename = generate_filename(output_directory, 'reservations_export')

        fieldnames = [
            'ID Reservation', 'ID Utilisateur', 'Nom Utilisateur', 'Prenom Utilisateur',
            'ID Vehicule', 'Marque Vehicule', 'Modele Vehicule',
            'Date Debut', 'Date Fin', 'Nombre Places Reservees'
        ]

        rows = [
            {
                'ID Reservation': row['id_reservation'],
                'ID Utilisateur': row['id_utilisateur'],
                'Nom Utilisateur': row['utilisateur_nom'],
                'Prenom Utilisateur': row['utilisateur_prenom'],
                'ID Vehicule': row['id_vehicule'],
                'Marque Vehicule': row['vehicule_marque'],
                'Modele Vehicule': row['vehicule_modele'],
                'Date Debut': row['date_debut'],
                'Date Fin': row['date_fin'],
                'Nombre Places Reservees': row['nb_places_reservees']
            }
            for row in result
        ]

        write_to_csv(filename, fieldnames, rows)

        return filename

    except Exception as e:
        print(f"Error exporting reservations: {e}")
        dbpool.query("ROLLBACK")
        raise


def export_vehicle_mileage_to_csv(output_directory: str = 'exports') -> str:
    """
    Export mileage data for all vehicles to a CSV file.

    Args:
        output_directory (str): Directory to save the CSV file. Defaults to 'exports'.

    Returns:
        str: Full path to the generated CSV file
    """
    try:
        create_output_directory(output_directory)

        result = dbpool.query(
            """
            SELECT 
                r.id_vehicule, 
                v.marque, 
                v.modele, 
                r.releve_km, 
                r.date_releve, 
                r.source_releve
            FROM 
                releve_km r
            LEFT JOIN 
                vehicule v ON r.id_vehicule = v.id_vehicule
            """
        )

        filename = generate_filename(
            output_directory, 'vehicule_kilometrage_export')

        fieldnames = [
            'ID Vehicule', 'Marque', 'Modele',
            'Kilometrage', 'Date Releve', 'Source Releve'
        ]

        rows = [
            {
                'ID Vehicule': row['id_vehicule'],
                'Marque': row['marque'],
                'Modele': row['modele'],
                'Kilometrage': row['releve_km'],
                'Date Releve': row['date_releve'],
                'Source Releve': row['source_releve']
            }
            for row in result
        ]

        write_to_csv(filename, fieldnames, rows)

        return filename

    except Exception as e:
        print(f"Error exporting vehicle mileage: {e}")
        dbpool.query("ROLLBACK")
        raise

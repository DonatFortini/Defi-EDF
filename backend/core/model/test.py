import re
import cv2
import easyocr
import os
import json

# Initialiser le lecteur EasyOCR
reader = easyocr.Reader(['fr'], gpu=True)  # Langue française, avec GPU activé

# Regex pour détecter les plaques françaises (format AA-000-AA)
plate_pattern = re.compile(r'[A-Z0-9]{2}-[0-9]{3}-[A-Z0-9]{2}')

# Chemin vers le fichier JSON
HOME_PATH = os.getcwd()
json_file_path = os.path.join(HOME_PATH, 'backend', 'core', 'datasets', 'CV_immatriculation', 'output.json')
output_results = []

# Fonction pour extraire les plaques d'immatriculation
def extract_french_plate(image_path):
    # Lecture de l'image
    image = cv2.imread(image_path)
    if image is None:
        return [], f"Erreur: Impossible de lire l'image {image_path}"

    # Reconnaissance de texte
    results = reader.readtext(image)

    # Recherche de plaques dans les résultats
    found_plates = []
    for (bbox, text, prob) in results:
        match = plate_pattern.match(text)
        if match:
            plate = match.group()
            # Supprimer les caractères `:` ou `;` à la fin
            plate = re.sub(r'[:;]$', '', plate)
            found_plates.append({
                "plate": plate,
                "confidence": prob,
                "bounding_box": str(bbox)
            })

    return found_plates, None

# Charger les données du JSON
with open(json_file_path, 'r', encoding='utf-8') as f:
    images_data = json.load(f)

# Boucle pour traiter chaque image
for entry in images_data:
    image_path = entry.get("path")
    file_name = entry.get("file_name")
    key_name = entry.get("key_name")

    try:
        # Appliquer EasyOCR à l'image
        result = extract_french_plate(image_path)
        # Formater le résultat
        formatted_result = {
            "file_name": file_name,
            "key_name": key_name,
            "detections": result[0]
        }
        # Ajouter au tableau des résultats
        output_results.append(formatted_result)
        print(f"Traitement réussi pour l'image : {file_name}")
    except Exception as e:
        print(f"Erreur lors du traitement de l'image {file_name} : {e}")

# Sauvegarder les résultats dans un fichier JSON
output_json_path = os.path.join(HOME_PATH, 'backend', 'core', 'datasets', 'CV_immatriculation', 'output_results.json')
with open(output_json_path, 'w', encoding='utf-8') as f:
    json.dump(output_results, f, ensure_ascii=False, indent=4)

print(f"Traitement terminé. Résultats sauvegardés dans {output_json_path}")
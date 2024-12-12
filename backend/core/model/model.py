import easyocr
import json
import os
import torch

# Charger le fichier JSON
HOME_PATH = os.getcwd()
print(HOME_PATH)
json_file_path = f"{HOME_PATH}\\backend\\core\\datasets\\CV_immatriculation\\output.json"  # Remplacez par le chemin vers votre fichier JSON
output_results = []

# Initialiser le lecteur EasyOCR
reader = easyocr.Reader(['fr'],gpu=True)  # Langue française

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
        result = reader.readtext(image_path)
        # Formater le résultat
        formatted_result = {
            "file_name": file_name,
            "key_name": key_name,
            "detections": [
                {
                    "text": text,
                    "confidence": confidence,
                    "bounding_box": str(bbox)
                }
                for bbox, text, confidence in result
            ]
        }
        # Ajouter au tableau des résultats
        output_results.append(formatted_result)
        print(f"Traitement réussi pour l'image : {file_name}")
    except Exception as e:
        print(f"Erreur lors du traitement de l'image {file_name} : {e}")

# Sauvegarder les résultats dans un fichier JSON
output_json_path = f"{HOME_PATH}\\backend\\core\\datasets\\CV_immatriculation\\output_results.json"
with open(output_json_path, 'w', encoding='utf-8') as f:
    json.dump(output_results, f, ensure_ascii=False, indent=4)

print(f"Traitement terminé. Résultats sauvegardés dans {output_json_path}")

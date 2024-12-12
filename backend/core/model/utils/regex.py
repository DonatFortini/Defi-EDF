import easyocr
import re
import cv2
from pathlib import Path

def extract_french_plate(image_path):
    # Initialisation du reader
    reader = easyocr.Reader(['fr'])
    
    # Pattern regex pour les plaques françaises (AA-000-AA)
    plate_pattern = re.compile(r'[A-Z0-9]{2}[-]?[A-Z0-9]{3}[-]?[A-Z0-9]{2}')
    
    # Lecture de l'image
    image = cv2.imread(str(image_path))
    if image is None:
        return "Erreur: Impossible de lire l'image"
    
    # Reconnaissance de texte
    results = reader.readtext(image)
    
    # Recherche de la plaque dans les résultats
    found_plates = []
    for (bbox, text, prob) in results:
        # Nettoyage du texte
        cleaned_text = text.upper().replace(' ', '-')
        
        # Si le texte correspond au format de plaque
        if plate_pattern.match(cleaned_text):
            found_plates.append({
                'plate': cleaned_text,
                'confidence': prob,
                'bbox': bbox
            })
    
    # Tri par niveau de confiance
    found_plates.sort(key=lambda x: x['confidence'], reverse=True)
    
    return found_plates

# Utilisation
image_path = Path("C:\\Users\\matth\\Documents\\cours_M1\\hackathon\\Defi-EDF\\backend\\core\\datasets\\CV_immatriculation\\test\\WhatsApp Image 2024-12-10 at 09.05.29 (1).jpeg")
plates = extract_french_plate(image_path)

if plates:
    for plate in plates:
        print(f"Plaque trouvée: {plate['plate']}")
        print(f"Niveau de confiance: {plate['confidence']:.2f}")
else:
    print("Aucune plaque d'immatriculation française trouvée")
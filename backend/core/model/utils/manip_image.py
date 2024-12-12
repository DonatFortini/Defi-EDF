from PIL import Image, ImageOps
import numpy as np
import os

def augment_image(image_path, output_dir):
    # Charger l'image
    image = Image.open(image_path)

    # Obtenir le nom de base du fichier sans extension
    base_name = os.path.splitext(os.path.basename(image_path))[0]

    # 1. Sauvegarder l'image originale
    image.save(os.path.join(output_dir, f"{base_name}_original.png"))

    # 2. Conversion en noir et blanc
    bw_image = ImageOps.grayscale(image)
    bw_image.save(os.path.join(output_dir, f"{base_name}_bw.png"))

    # 3. Rotation
    for angle in [90, 180, 270]:
        rotated_image = image.rotate(angle)
        rotated_image.save(os.path.join(output_dir, f"{base_name}_rotated_{angle}.png"))

    # 4. Retournement horizontal et vertical
    flipped_h = ImageOps.mirror(image)
    flipped_h.save(os.path.join(output_dir, f"{base_name}_flipped_h.png"))

    flipped_v = ImageOps.flip(image)
    flipped_v.save(os.path.join(output_dir, f"{base_name}_flipped_v.png"))

    # 5. Redimensionnement (ajout de bruit dans les dimensions)
    for scale in [0.5, 1.5]:
        width, height = image.size
        resized_image = image.resize((int(width * scale), int(height * scale)))
        resized_image.save(os.path.join(output_dir, f"{base_name}_resized_{scale}.png"))

    # 6. Ajout de bruit (simple variation de pixels)
    np_image = np.array(image)
    noise = np.random.randint(0, 50, np_image.shape, dtype='uint8')
    noisy_image = Image.fromarray(np.clip(np_image + noise, 0, 255).astype('uint8'))
    noisy_image.save(os.path.join(output_dir, f"{base_name}_noisy.png"))

# Exemple d'utilisation
def augment_dataset(input_dir, output_dir):
    print(f"Chemin du dossier de sortie: {output_dir}")  # Ajoutez cette ligne pour vérifier le chemin

    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for filename in os.listdir(input_dir):
        if filename.lower().endswith(('png', 'jpg', 'jpeg', 'bmp', 'tiff')):
            image_path = os.path.join(input_dir, filename)
            augment_image(image_path, output_dir)

# Spécifiez vos répertoires
input_directory = "C:/Users/matth/Documents/cours_M1/hackathon/Defi-EDF/backend/core/datasets/CV_immatriculation/test"  # Chemin du dossier d'entrée
output_directory = "C:/Users/matth/Documents/cours_M1/hackathon/Defi-EDF/backend/core/datasets/CV_immatriculation/test"  # Chemin du dossier de sortie

augment_dataset(input_directory, output_directory)
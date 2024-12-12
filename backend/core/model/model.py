import easyocr
reader = easyocr.Reader(['fr'])  # Pour les plaques françaises
result = reader.readtext('C:\\Users\\matth\\Documents\\cours_M1\\hackathon\\Defi-EDF\\backend\\core\\datasets\\CV_immatriculation\\test\\WhatsApp Image 2024-12-10 at 09.05.28 (1)_bw.png')
print(result)
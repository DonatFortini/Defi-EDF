from fastapi import FastAPI, HTTPException, File, UploadFile
from pydantic import BaseModel
import httpx
from typing import Dict, Optional
import os
import tempfile

# Modèles Pydantic correspondant à la structure exacte de l'API Fleet
class DispoStatus(BaseModel):
    free: int
    leased: int

class PropulsionStatus(BaseModel):
    electric: int
    thermic: int

class DashboardResponse(BaseModel):
    dispo: DispoStatus
    propulsion: PropulsionStatus

class LoginRequest(BaseModel):
   email: str
   password: str

class LoginResponse(BaseModel):
   token: str
   refresh_token: Optional[str] = None
   user_id: int
   email: str

app = FastAPI()

# Configuration
FLEET_API_URL = "http://127.0.0.1:5000"  # À ajuster selon votre configuration
TIMEOUT = 10.0

@app.get("/api/public/dashboard", response_model=DashboardResponse)
async def get_dashboard():
    """
    Récupère les données du dashboard depuis le service Fleet
    Retourne un objet avec la disponibilité et les types de propulsion
    """
    async with httpx.AsyncClient(timeout=TIMEOUT) as client:
        try:
            response = await client.get(f"{FLEET_API_URL}/Fleet/dashboard")
            response.raise_for_status()

            # Les données correspondent déjà au format attendu, pas besoin de transformation
            return DashboardResponse(**response.json())

        except httpx.RequestError as e:
            raise HTTPException(
                status_code=503,
                detail=f"Erreur de connexion au service Fleet: {str(e)}"
            )
        except httpx.HTTPStatusError as e:
            raise HTTPException(
                status_code=e.response.status_code,
                detail=f"Erreur du service Fleet: {e.response.text}"
            )

# Exemple d'utilisation avec des statistiques additionnelles
@app.get("/api/public/dashboard/stats")
async def get_dashboard_with_stats():
    """
    Version enrichie qui ajoute des statistiques calculées
    """
    async with httpx.AsyncClient(timeout=TIMEOUT) as client:
        try:
            response = await client.get(f"{FLEET_API_URL}/Fleet/dashboard")
            response.raise_for_status()

            data = response.json()

            # Ajout de statistiques calculées
            total_vehicles = data["dispo"]["free"] + data["dispo"]["leased"]
            total_by_propulsion = data["propulsion"]["electric"] + data["propulsion"]["thermic"]

            return {
                **data,  # Données originales
                "statistics": {
                    "total_vehicles": total_vehicles,
                    "occupancy_rate": round((data["dispo"]["leased"] / total_vehicles) * 100, 1) if total_vehicles > 0 else 0,
                    "electric_rate": round((data["propulsion"]["electric"] / total_by_propulsion) * 100, 1) if total_by_propulsion > 0 else 0
                }
            }

        except httpx.RequestError as e:
            raise HTTPException(
                status_code=503,
                detail=f"Erreur de connexion au service Fleet: {str(e)}"
            )

@app.post("/api/public/login")
async def login(login_data: LoginRequest):
   try:
       # Créer un client HTTP
       async with httpx.AsyncClient() as client:
           # Faire la requête vers l'API privée
           response = await client.post(
               f"{FLEET_API_URL}/auth/login",  # Route privée
               json={
                   "email": login_data.email,
                   "password": login_data.password
               },
               headers={
                   "Content-Type": "application/json"
               }
           )

           # Retourner la réponse de l'API privée
           return response.json()

   except Exception as e:
       raise HTTPException(
           status_code=500,
           detail=f"Une erreur est survenue: {str(e)}"
       )

@app.post("/api/upload/plate-number")
async def upload_plate_number(file: UploadFile = File(...)):
    """
    Endpoint pour l'extraction du numéro de plaque d'immatriculation
    à partir d'une image.
    """
    try:
        # Sauvegarde temporaire du fichier
        with tempfile.NamedTemporaryFile(delete=False) as temp_file:
            temp_file.write(await file.read())
            temp_file_path = temp_file.name

        try:
            # Envoi au service OCR
            async with httpx.AsyncClient() as client:
                with open(temp_file_path, "rb") as f:
                    files = {"file": (file.filename, f, file.content_type)}
                    response = await client.post(
                        f"{FLEET_API_URL}/OCR/PlateNumber",
                        files=files,
                        timeout=30.0
                    )
                    response.raise_for_status()
                    return response.json()

        except httpx.RequestError as e:
            raise HTTPException(
                status_code=503,
                detail=f"Erreur de connexion au service OCR: {str(e)}"
            )
        except httpx.HTTPStatusError as e:
            raise HTTPException(
                status_code=e.response.status_code,
                detail=f"Erreur du service OCR: {e.response.text}"
            )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur interne du serveur: {str(e)}"
        )
    finally:
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)

@app.post("/api/upload/mileage")
async def upload_mileage(file: UploadFile = File(...)):
    """
    Endpoint pour l'extraction du kilométrage à partir d'une image.
    """
    try:
        # Sauvegarde temporaire du fichier
        with tempfile.NamedTemporaryFile(delete=False) as temp_file:
            temp_file.write(await file.read())
            temp_file_path = temp_file.name

        try:
            # Envoi au service OCR
            async with httpx.AsyncClient() as client:
                with open(temp_file_path, "rb") as f:
                    files = {"file": (file.filename, f, file.content_type)}
                    response = await client.post(
                        f"{FLEET_API_URL}/OCR/Mileage",
                        files=files,
                        timeout=30.0
                    )
                    response.raise_for_status()
                    return response.json()

        except httpx.RequestError as e:
            raise HTTPException(
                status_code=503,
                detail=f"Erreur de connexion au service OCR: {str(e)}"
            )
        except httpx.HTTPStatusError as e:
            raise HTTPException(
                status_code=e.response.status_code,
                detail=f"Erreur du service OCR: {e.response.text}"
            )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erreur interne du serveur: {str(e)}"
        )
    finally:
        if os.path.exists(temp_file_path):
            os.remove(temp_file_path)



if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

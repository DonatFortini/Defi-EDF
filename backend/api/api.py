from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import httpx
from typing import Dict

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

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
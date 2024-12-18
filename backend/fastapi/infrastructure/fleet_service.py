import httpx
from fastapi import HTTPException
from domain.interfaces.fleet_service import FleetServiceInterface
from domain.models import DashboardResponse, LoginRequest, LoginResponse
from config.settings import Settings


class FleetService(FleetServiceInterface):
    def __init__(self, settings: Settings):
        self.api_url = settings.FLEET_API_URL
        self.timeout = settings.TIMEOUT

    async def get_dashboard(self) -> DashboardResponse:
        async with httpx.AsyncClient(timeout=self.timeout) as client:
            try:
                response = await client.get(f"{self.api_url}/Fleet/dashboard")
                response.raise_for_status()
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

    async def get_dashboard_with_stats(self) -> dict:
        async with httpx.AsyncClient(timeout=self.timeout) as client:
            try:
                response = await client.get(f"{self.api_url}/Fleet/dashboard")
                response.raise_for_status()

                data = response.json()
                total_vehicles = data["dispo"]["free"] + \
                    data["dispo"]["leased"]
                total_by_propulsion = data["propulsion"]["electric"] + \
                    data["propulsion"]["thermic"]

                return {
                    **data,
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

    async def login(self, login_data: LoginRequest) -> LoginResponse:
        try:
            async with httpx.AsyncClient() as client:
                response = await client.post(
                    f"{self.api_url}/auth/login",
                    json=login_data.dict(),
                    headers={"Content-Type": "application/json"}
                )
                return LoginResponse(**response.json())
        except Exception as e:
            raise HTTPException(
                status_code=500,
                detail=f"Une erreur est survenue: {str(e)}"
            )

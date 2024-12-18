from fastapi import APIRouter, Depends
from domain.models import DashboardResponse
from domain.interfaces.fleet_service import FleetServiceInterface
from infrastructure.fleet_service import FleetService
from config.settings import Settings

router = APIRouter()


@router.get("/dashboard", response_model=DashboardResponse)
async def get_dashboard(
    fleet_service: FleetServiceInterface = Depends(
        lambda: FleetService(Settings()))
):
    return await fleet_service.get_dashboard()


@router.get("/dashboard/stats")
async def get_dashboard_with_stats(
    fleet_service: FleetServiceInterface = Depends(
        lambda: FleetService(Settings()))
):
    return await fleet_service.get_dashboard_with_stats()

from fastapi import APIRouter, Depends
from domain.models import LoginRequest, LoginResponse
from domain.interfaces.fleet_service import FleetServiceInterface
from infrastructure.fleet_service import FleetService
from config.settings import Settings

router = APIRouter()


@router.post("/login", response_model=LoginResponse)
async def login(
    login_data: LoginRequest,
    fleet_service: FleetServiceInterface = Depends(
        lambda: FleetService(Settings()))
):
    return await fleet_service.login(login_data)

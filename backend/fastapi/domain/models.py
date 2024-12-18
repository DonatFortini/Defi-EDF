from pydantic import BaseModel
from typing import Optional


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

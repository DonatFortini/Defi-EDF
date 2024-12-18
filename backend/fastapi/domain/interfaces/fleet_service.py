from abc import ABC, abstractmethod
from domain.models import DashboardResponse, LoginRequest, LoginResponse


class FleetServiceInterface(ABC):
    @abstractmethod
    async def get_dashboard(self) -> DashboardResponse:
        pass

    @abstractmethod
    async def get_dashboard_with_stats(self) -> dict:
        pass

    @abstractmethod
    async def login(self, login_data: LoginRequest) -> LoginResponse:
        pass

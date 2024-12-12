from .route_optimizer import RouteOptimizerService
from .electric_consumption import ElectricConsumptionService
from .fuel_consumption import FuelConsumptionService
from .compartment_wear import CompartmentWearService
from .emissions import CO2EmissionsService
from .fuel_savings import FuelSavingsService

__all__ = [
    'RouteOptimizerService',
    'ElectricConsumptionService',
    'FuelConsumptionService',
    'CompartmentWearService',
    'CO2EmissionsService',
    'FuelSavingsService',
]
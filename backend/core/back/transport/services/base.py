# services/base.py
from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Dict, Any

@dataclass
class ServiceResult:
    success: bool
    data: Dict[str, Any]
    error: str = None

class BaseCalculationService(ABC):
    @abstractmethod
    def calculate(self, *args, **kwargs) -> ServiceResult:
        pass
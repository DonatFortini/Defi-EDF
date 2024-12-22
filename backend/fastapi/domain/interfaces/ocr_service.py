from config.settings import Settings
from fastapi import HTTPException, UploadFile
import httpx
import tempfile
import os
from abc import ABC, abstractmethod
from fastapi import UploadFile


class OCRServiceInterface(ABC):
    @abstractmethod
    async def extract_plate_number(self, file: UploadFile) -> dict:
        pass

    @abstractmethod
    async def extract_mileage(self, file: UploadFile) -> dict:
        pass


# src/infrastructure/ocr_service.py


class OCRService(OCRServiceInterface):
    def __init__(self, settings: Settings):
        self.api_url = settings.FLEET_API_URL
        self.timeout = 30.0

    async def _process_image(self, file: UploadFile, endpoint: str) -> dict:
        temp_file_path = None
        try:
            with tempfile.NamedTemporaryFile(delete=False) as temp_file:
                temp_file.write(await file.read())
                temp_file_path = temp_file.name

            async with httpx.AsyncClient() as client:
                with open(temp_file_path, "rb") as f:
                    files = {"file": (file.filename, f, file.content_type)}
                    response = await client.post(
                        f"{self.api_url}/OCR/{endpoint}",
                        files=files,
                        timeout=self.timeout
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
        finally:
            if temp_file_path and os.path.exists(temp_file_path):
                os.remove(temp_file_path)

    async def extract_plate_number(self, file: UploadFile) -> dict:
        return await self._process_image(file, "PlateNumber")

    async def extract_mileage(self, file: UploadFile) -> dict:
        return await self._process_image(file, "Mileage")

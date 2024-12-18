import httpx
from fastapi import HTTPException
from config.settings import Settings
from domain.interfaces.ocr_service import OCRServiceInterface


class OCRService(OCRServiceInterface):
    def __init__(self, settings: Settings):
        self.api_url = settings.OCR_API_URL
        self.timeout = settings.TIMEOUT

    async def extract_plate_number(self, file):
        async with httpx.AsyncClient(timeout=self.timeout) as client:
            try:
                response = await client.post(
                    f"{self.api_url}/plate-number",
                    files={"file": (file.filename, file.file,
                                    file.content_type)}
                )
                response.raise_for_status()
                return response.json()
            except httpx.RequestError as e:
                raise HTTPException(
                    status_code=503,
                    detail=f"Erreur de connexion au service OCR: {str(e)}"
                )

    async def extract_mileage(self, file):
        async with httpx.AsyncClient(timeout=self.timeout) as client:
            try:
                response = await client.post(
                    f"{self.api_url}/mileage",
                    files={"file": (file.filename, file.file,
                                    file.content_type)}
                )
                response.raise_for_status()
                return response.json()
            except httpx.RequestError as e:
                raise HTTPException(
                    status_code=503,
                    detail=f"Erreur de connexion au service OCR: {str(e)}"
                )

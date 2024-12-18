from fastapi import APIRouter, Depends, File, UploadFile
from domain.interfaces.ocr_service import OCRServiceInterface
from infrastructure.ocr_service import OCRService
from config.settings import Settings

router = APIRouter()


@router.post("/plate-number")
async def upload_plate_number(
    file: UploadFile = File(...),
    ocr_service: OCRServiceInterface = Depends(lambda: OCRService(Settings()))
):
    return await ocr_service.extract_plate_number(file)


@router.post("/mileage")
async def upload_mileage(
    file: UploadFile = File(...),
    ocr_service: OCRServiceInterface = Depends(lambda: OCRService(Settings()))
):
    return await ocr_service.extract_mileage(file)

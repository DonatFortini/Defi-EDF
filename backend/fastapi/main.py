from fastapi import FastAPI
from api.routes import dashboard, auth, ocr

app = FastAPI()

app.include_router(dashboard.router, prefix="/api/public", tags=["dashboard"])
app.include_router(auth.router, prefix="/api/public", tags=["auth"])
app.include_router(ocr.router, prefix="/api/upload", tags=["ocr"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

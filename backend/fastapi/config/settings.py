from pydantic import BaseSettings


class Settings(BaseSettings):
    FLEET_API_URL: str = "http://127.0.0.1:5000"
    TIMEOUT: float = 10.0

    class Config:
        env_file = ".env"

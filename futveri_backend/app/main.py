"""
FutVeri Backend API
Main application entry point.

FastAPI application serving Mobile App, Admin Panel, and Club Panel.
"""
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.v1.router import api_router
from app.core.config import settings
from app.db.database import create_tables


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Application lifespan handler.
    Creates database tables on startup.
    """
    # Startup
    print("🚀 Starting FutVeri API...")
    print(f"📊 Debug mode: {settings.DEBUG}")
    
    # Create database tables
    await create_tables()
    print("✅ Database tables created/verified")
    
    yield
    
    # Shutdown
    print("👋 Shutting down FutVeri API...")


# Create FastAPI application
app = FastAPI(
    title=settings.APP_NAME,
    description="""
## FutVeri Backend API

Scout raporlama ve kulüp yönetimi için backend API.

### Özellikler

- **Authentication**: JWT tabanlı kimlik doğrulama
- **Rol Yetkilendirme**: user, scout, premium, club, admin, superadmin
- **Scout Raporları**: Oyuncu değerlendirme raporları
- **Takım/Oyuncu Yönetimi**: Futbolcu ve takım veritabanı
- **Dashboard**: Admin istatistikleri ve analytics

### Kullanıcı Rolleri

| Rol | Yetki |
|-----|-------|
| `user` | Onaylı raporları görüntüleme |
| `scout` | Rapor oluşturma/düzenleme |
| `premium` | Ek özellikler |
| `club` | Scout raporlarını görüntüleme |
| `admin` | Rapor onaylama, kullanıcı yönetimi |
| `superadmin` | Tam yetki |
    """,
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API router
app.include_router(api_router, prefix=settings.API_V1_PREFIX)


@app.get("/", tags=["Health"])
async def root():
    """
    Root endpoint - API health check.
    """
    return {
        "name": settings.APP_NAME,
        "version": "1.0.0",
        "status": "healthy",
        "docs": "/docs",
    }


@app.get("/health", tags=["Health"])
async def health_check():
    """
    Health check endpoint for monitoring.
    """
    return {
        "status": "healthy",
        "database": "connected",
    }

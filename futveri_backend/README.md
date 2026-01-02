# FutVeri Backend API

FastAPI ile yazılmış, mobil uygulama, admin paneli ve kulüp paneli için backend API.

## Özellikler

- 🔐 **JWT Authentication**: Token tabanlı kimlik doğrulama
- 👥 **Rol Tabanlı Yetkilendirme**: user, scout, premium, club, admin, superadmin
- 📊 **Scout Raporları**: Detaylı oyuncu değerlendirme sistemi
- ⚽ **Takım/Oyuncu Yönetimi**: Kapsamlı veritabanı
- 📈 **Dashboard API**: Admin istatistikleri

## Kurulum

### 1. Virtual Environment Oluştur

```bash
cd futveri_backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
```

### 2. Bağımlılıkları Yükle

```bash
pip install -r requirements.txt
```

### 3. Environment Variables

`.env.example` dosyasını `.env` olarak kopyalayın ve değerleri güncelleyin:

```bash
cp .env.example .env
```

**Supabase PostgreSQL için:**
1. [Supabase](https://supabase.com) hesabı oluşturun
2. Yeni proje oluşturun
3. Settings > Database > Connection string (URI) kopyalayın
4. `.env` dosyasındaki `DATABASE_URL` değerini güncelleyin:
   ```
   DATABASE_URL=postgresql+asyncpg://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
   ```

### 4. Uygulamayı Başlat

```bash
uvicorn app.main:app --reload
```

API: http://localhost:8000
Swagger Docs: http://localhost:8000/docs
ReDoc: http://localhost:8000/redoc

## API Endpoints

### Authentication
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| POST | `/api/v1/auth/register` | Kullanıcı kaydı |
| POST | `/api/v1/auth/register/club` | Kulüp kaydı |
| POST | `/api/v1/auth/login` | Giriş |
| POST | `/api/v1/auth/refresh` | Token yenileme |
| GET | `/api/v1/auth/me` | Mevcut kullanıcı |

### Users (Admin)
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/users` | Kullanıcı listesi |
| GET | `/api/v1/users/stats` | Kullanıcı istatistikleri |
| GET | `/api/v1/users/{id}` | Kullanıcı detayı |
| PUT | `/api/v1/users/{id}` | Profil güncelleme |
| DELETE | `/api/v1/users/{id}` | Kullanıcı silme |

### Scout Reports
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/reports` | Rapor listesi |
| POST | `/api/v1/reports` | Yeni rapor |
| GET | `/api/v1/reports/{id}` | Rapor detayı |
| PUT | `/api/v1/reports/{id}` | Rapor güncelleme |
| DELETE | `/api/v1/reports/{id}` | Rapor silme |
| POST | `/api/v1/reports/{id}/submit` | Rapor gönderme |
| POST | `/api/v1/reports/{id}/approve` | Rapor onaylama |
| POST | `/api/v1/reports/{id}/reject` | Rapor reddetme |

### Players
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/players` | Oyuncu listesi |
| POST | `/api/v1/players` | Yeni oyuncu |
| GET | `/api/v1/players/{id}` | Oyuncu detayı |
| PUT | `/api/v1/players/{id}` | Oyuncu güncelleme |
| DELETE | `/api/v1/players/{id}` | Oyuncu silme |

### Teams
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/teams` | Takım listesi |
| POST | `/api/v1/teams` | Yeni takım |
| GET | `/api/v1/teams/{id}` | Takım detayı |
| PUT | `/api/v1/teams/{id}` | Takım güncelleme |
| DELETE | `/api/v1/teams/{id}` | Takım silme |

### Dashboard (Admin)
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/dashboard` | Tam dashboard |
| GET | `/api/v1/dashboard/stats` | İstatistikler |
| GET | `/api/v1/dashboard/pending` | Bekleyen işlemler |
| GET | `/api/v1/dashboard/recent-activity` | Son aktiviteler |

## Proje Yapısı

```
futveri_backend/
├── app/
│   ├── __init__.py
│   ├── main.py                 # FastAPI uygulama
│   ├── core/
│   │   ├── config.py           # Ayarlar
│   │   ├── security.py         # JWT, hashing
│   │   └── dependencies.py     # Auth middleware
│   ├── models/
│   │   ├── user.py
│   │   ├── scout_report.py
│   │   ├── player.py
│   │   ├── team.py
│   │   ├── club.py
│   │   └── post.py
│   ├── schemas/
│   │   ├── auth.py
│   │   ├── user.py
│   │   ├── scout_report.py
│   │   ├── player.py
│   │   ├── team.py
│   │   ├── post.py
│   │   └── dashboard.py
│   ├── api/v1/
│   │   ├── router.py
│   │   ├── auth.py
│   │   ├── users.py
│   │   ├── reports.py
│   │   ├── players.py
│   │   ├── teams.py
│   │   └── dashboard.py
│   └── db/
│       └── database.py
├── requirements.txt
├── .env.example
└── README.md
```

## Kullanıcı Rolleri

| Rol | Açıklama | Yetkiler |
|-----|----------|----------|
| `user` | Normal kullanıcı | Onaylı raporları görüntüleme |
| `scout` | Scout | Rapor oluşturma/düzenleme |
| `premium` | Premium kullanıcı | Ek özellikler |
| `club` | Kulüp hesabı | Scout raporlarını görüntüleme |
| `admin` | Admin | Rapor onaylama, kullanıcı yönetimi |
| `superadmin` | Süper Admin | Tam yetki |

## Test

İlk admin kullanıcısını oluşturmak için:

```python
# Python shell'de
from app.core.security import get_password_hash

# Şifre hash'le
hashed = get_password_hash("admin123")
print(hashed)

# Supabase SQL Editor'de:
# INSERT INTO users (id, email, hashed_password, name, role, is_active, is_verified)
# VALUES (gen_random_uuid(), 'admin@futveri.com', '<hashed>', 'Admin', 'superadmin', true, true);
```

## Flutter Entegrasyonu

Flutter uygulamasında API'yi kullanmak için:

```dart
// lib/core/api/api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  
  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8000/api/v1',
    headers: {'Content-Type': 'application/json'},
  ));
  
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  Future<Response> login(String email, String password) async {
    return _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }
  
  Future<Response> getReports({int page = 1, int size = 20}) async {
    return _dio.get('/reports', queryParameters: {
      'page': page,
      'size': size,
    });
  }
}
```

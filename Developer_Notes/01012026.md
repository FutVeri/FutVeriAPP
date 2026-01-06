# 📋 FutVeri - Geliştirici Notları

> Bu dosya backend ve frontend ekiplerinin iletişimi için kullanılacaktır.
> Her güncelleme sonrası bu dosyayı güncelleyin.

---

## 🔧 BACKEND TARAFINDAKİ GELİŞMELER (3 Ocak 2026)

### Hazır API Endpoint'leri

Backend tamamen çalışır durumda. Aşağıdaki tüm endpoint'ler test edilmiş ve kullanıma hazır.

#### 1. Authentication (Kimlik Doğrulama)
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| POST | `/api/v1/auth/register` | Yeni kullanıcı kaydı |
| POST | `/api/v1/auth/register/club` | Kulüp kaydı |
| POST | `/api/v1/auth/login` | Giriş (JWT token alır) |
| POST | `/api/v1/auth/refresh` | Token yenileme |
| GET | `/api/v1/auth/me` | Mevcut kullanıcı bilgisi |
| POST | `/api/v1/auth/change-password` | Şifre değiştirme |

#### 2. Users (Kullanıcılar)
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/users` | Kullanıcı listesi (admin) |
| GET | `/api/v1/users/stats` | Kullanıcı istatistikleri |
| GET | `/api/v1/users/{id}` | Kullanıcı detayı |
| PUT | `/api/v1/users/{id}` | Profil güncelleme |
| DELETE | `/api/v1/users/{id}` | Kullanıcı silme |

#### 3. Scout Reports (Raporlar)
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/reports` | Rapor listesi |
| POST | `/api/v1/reports` | Yeni rapor oluştur |
| GET | `/api/v1/reports/stats` | Rapor istatistikleri |
| GET | `/api/v1/reports/{id}` | Rapor detayı |
| PUT | `/api/v1/reports/{id}` | Rapor güncelle |
| DELETE | `/api/v1/reports/{id}` | Rapor sil |
| POST | `/api/v1/reports/{id}/submit` | Onaya gönder |
| POST | `/api/v1/reports/{id}/approve` | Onayla (admin) |
| POST | `/api/v1/reports/{id}/reject` | Reddet (admin) |

#### 4. Posts (Sosyal Paylaşımlar) - YENİ ✨
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/posts` | Feed listesi |
| POST | `/api/v1/posts` | Post oluştur |
| GET | `/api/v1/posts/{id}` | Post detayı |
| PUT | `/api/v1/posts/{id}` | Post güncelle |
| DELETE | `/api/v1/posts/{id}` | Post sil |
| POST | `/api/v1/posts/{id}/like` | Beğen |
| DELETE | `/api/v1/posts/{id}/like` | Beğeniyi kaldır |
| GET | `/api/v1/posts/{id}/comments` | Yorumları getir |
| POST | `/api/v1/posts/{id}/comments` | Yorum ekle |
| DELETE | `/api/v1/posts/{id}/comments/{id}` | Yorum sil |

#### 5. Dashboard (Admin Panel)
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET | `/api/v1/dashboard` | Tam dashboard |
| GET | `/api/v1/dashboard/stats` | İstatistikler |
| GET | `/api/v1/dashboard/pending` | Bekleyen işlemler |
| GET | `/api/v1/dashboard/recent-activity` | Son aktiviteler |

#### 6. Players & Teams
| Method | Endpoint | Açıklama |
|--------|----------|----------|
| GET/POST | `/api/v1/players` | Oyuncu CRUD |
| GET/POST | `/api/v1/teams` | Takım CRUD |

---

### 🔑 Test Kullanıcısı

```
Email: admin@futveri.com
Şifre: FutVeri2026!
Rol: scout
```

### 🌐 API Adresleri

- **Local**: http://localhost:8000
- **Swagger Docs**: http://localhost:8000/docs
- **Database**: Supabase PostgreSQL

---

## 📱 MOBİL TARAFINDAKİ GELİŞMELER

> Mobil ekibi bu bölümü güncellesin

### Yapılan İşler:
- [ ] ...

### API'ye Bağlanması Gereken Sayfalar:
- [ ] Login sayfası → `/api/v1/auth/login` kullanacak
- [ ] Scout dashboard → `/api/v1/reports` ile rapor listesi
- [ ] Create report → `/api/v1/reports` POST ile rapor oluşturma
- [ ] Social feed → `/api/v1/posts` ile feed

---

## 🖥️ DASHBOARD (ADMIN PANEL) GELİŞMELERİ

> Dashboard ekibi bu bölümü güncellesin

### Yapılan İşler:
- [ ] ...

### API'ye Bağlanması Gereken:
- [ ] Dashboard stats → `/api/v1/dashboard/stats`
- [ ] Reports list → `/api/v1/reports`
- [ ] Users list → `/api/v1/users`
- [ ] Report approval → `/api/v1/reports/{id}/approve`

---

## 📝 İLETİŞİM NOTLARI

> Ekipler arası notlar buraya yazılsın

### Backend → Frontend:
- MockDataService yerine gerçek API kullanılmalı
- API client hazır: `futveri/lib/core/api/` klasöründe
- Auth service hazır: `futveri/lib/features/auth/data/auth_service.dart`

### Frontend → Backend:
- ...

---

## 🗓️ SONRAKİ ADIMLAR

1. **Mobil**: Login sayfasını API'ye bağla
2. **Dashboard**: MockDataService → API calls
3. **Backend**: Frontend isteklerine göre yeni endpoint ekle

---

*Son Güncelleme: 3 Ocak 2026 - Backend Ekibi*

# ✈️ TripNest — Collaborative Travel Planning & Trip Management Platform

[![Next.js](https://img.shields.io/badge/Next.js-16-black?style=for-the-badge&logo=next.js)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-19-61DAFB?style=for-the-badge&logo=react&logoColor=black)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Java](https://img.shields.io/badge/Java-21-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://adoptium.net/)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.1.0-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)](https://spring.io/projects/spring-boot)
[![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)

**TripNest** is a full-stack, production-ready travel planning platform engineered to help travelers organize itineraries, track budgets and shared expenses, discover destinations with live weather forecasts, and collaborate with travel companions in real time.

---

## 🌟 Key Features

- **🔐 Authentication & RBAC**:
  - Stateless JWT-based authentication using Spring Security.
  - Role-Based Access Control (`TRAVELER`, `GROUP_ADMIN`, `ADMINISTRATOR`).
  - Pre-seeded default administrator account.
- **🗺️ Destination Discovery & Live Weather**:
  - Curated catalog of global destinations with descriptions and highlights.
  - Real-world place search and geocoding via OpenStreetMap (Nominatim).
  - Real-time weather forecasts integrated with OpenWeatherMap API.
- **🧳 Trip Management**:
  - Create, view, update, and manage trips with custom start/end dates and statuses (`PLANNED`, `COMPLETED`, etc.).
  - Search public trips and send join requests.
- **👥 Group Collaboration**:
  - Invite travel members via email with granular roles (`OWNER`, `GROUP_ADMIN`, `MEMBER`).
  - Request-to-join workflow with owner approval.
- **💰 Budgeting & Expense Tracking**:
  - Set trip-level budgets across multiple currencies.
  - Log itemized expenses (Transportation, Hotel, Food, Shopping, Entertainment, Miscellaneous) with receipt links.
  - Real-time remaining budget calculations.
  - Interactive category spending breakdown visualized with Chart.js doughnut charts.
- **📅 Itinerary & Activity Planning**:
  - Day-by-day scheduling with start/end times, locations, and descriptions.
- **⏰ Automated Reminders & Notifications**:
  - Daily scheduled cron service (`@Scheduled`) checking for trips starting tomorrow and activities within 24 hours.
  - In-app notification bell with unread counters and read status tracking.
  - Automated email notifications dispatched via Spring Mail (SMTP).
- **📁 Travel Documents & Media Vault**:
  - Upload, store, and manage travel tickets, hotel reservations, and images (up to 10MB).
- **❤️ Favorites & Travel Preferences**:
  - Save favorite destinations to a personal board.
  - Store personalized travel preferences (climate, travel style, accommodation, budget range).

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Next.js 16 (App Router, Turbopack)
- **UI & Components**: React 19, TypeScript 5
- **Styling**: Tailwind CSS v4
- **Data Visualization**: Chart.js & `react-chartjs-2`
- **Deployment**: Vercel

### Backend
- **Framework**: Spring Boot 4.1.0
  - `spring-boot-starter-webmvc`
  - `spring-boot-starter-data-jpa`
  - `spring-boot-starter-security`
  - `spring-boot-starter-validation`
  - `spring-boot-starter-mail`
- **Language**: Java 21 (LTS)
- **Security & Tokens**: JJWT (`io.jsonwebtoken` 0.12.5), BCrypt Password Encoder
- **Database Migrations**: Flyway (`flyway-core`, `flyway-database-postgresql`)
- **Connection Pool**: HikariCP
- **Deployment**: Render

### Databases
- **Production**: Supabase PostgreSQL (with SSL enforced)
- **Local Development / Tests**: In-memory H2 Database (`jdbc:h2:mem:tripnest`) with web console

---

## 📂 Repository Structure

```
Travel-Planning/
├── .env.example                  # Environment variables template (no secrets)
├── render.yaml                   # Render.com Infrastructure-as-Code deployment spec
├── start-local.ps1               # Automated local dev runner for Windows
├── start-local.cmd               # Quick launcher shortcut
├── run-backend.ps1               # PowerShell runner for Spring Boot dev profile
├── Postman/
│   └── TripNest API.postman_collection.json # Complete API testing collection
├── frontend/                     # Next.js 16 Web Application
│   ├── app/
│   │   ├── layout.tsx & page.tsx # Root layout and landing page
│   │   ├── login/ & register/    # Authentication pages
│   │   ├── dashboard/            # Main traveler dashboard & notification dropdown
│   │   ├── trips/                # Trips list, /new (creation), /join (search & join)
│   │   │   └── [id]/             # Trip details (budget, expenses, chart, collaboration)
│   │   ├── destinations/         # Destinations explorer & detail views
│   │   ├── favorites/            # Saved dream destinations
│   │   ├── history/              # Past completed journeys
│   │   ├── profile/              # User profile
│   │   ├── preferences/          # Travel preferences form
│   │   ├── settings/             # Account settings
│   │   ├── components/           # UI components (user-shell, spending-chart, collaboration)
│   │   └── lib/api.ts            # Typed API client with JWT bearer session management
│   ├── package.json
│   └── tsconfig.json
└── tripnest-backend/             # Spring Boot 4 REST API
    ├── pom.xml
    ├── src/main/resources/
    │   ├── application.properties     # Production / PostgreSQL profile
    │   ├── application-dev.properties # Local H2 in-memory profile
    │   ├── application-prod.properties# Dedicated Supabase PostgreSQL profile
    │   └── db/migration/              # Flyway database migrations
    │       ├── V1__initial_schema.sql # Complete 16-table schema & indexes
    │       └── V2__seed_initial_data.sql # Initial roles and curated destinations
    └── src/main/java/com/tripnest/tripnest_backend/
        ├── config/               # SecurityConfig, DataSeeder, SchedulingConfig
        ├── controller/           # 17 REST controllers
        ├── dto/                  # Request/Response DTOs
        ├── entity/               # 13 JPA entities
        ├── repository/           # Spring Data JPA repositories
        ├── security/             # JwtAuthFilter, JwtUtil, CustomUserDetailsService
        └── service/              # Core business services & scheduled reminder jobs
```

---

## 🚀 Quick Start (Local Development)

### Prerequisites
- **Java 21** or later (`java -version`)
- **Node.js v20+** and `npm` (`node -v`)

### Option A: One-Click Launch (Windows)
From the root directory, execute:
```powershell
.\start-local.ps1
```
- **Frontend**: [http://localhost:3000](http://localhost:3000)
- **Backend**: [http://localhost:8080](http://localhost:8080)
- **Logs**: Saved automatically to `.local-logs/`

---

### Option B: Manual Startup

#### 1. Start the Backend (H2 In-Memory Profile)
```powershell
cd tripnest-backend
.\mvnw.cmd spring-boot:run -Dspring-boot.run.profiles=dev
```
- **H2 Console**: [http://localhost:8080/h2-console](http://localhost:8080/h2-console)
  - JDBC URL: `jdbc:h2:mem:tripnest`
  - User: `sa`
  - Password: *(leave blank)*
- **Pre-seeded Admin Account**:
  - Email: `admin@tripnest.com`
  - Password: `Admin@123`

#### 2. Start the Frontend
```powershell
cd frontend
npm install
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## ⚙️ Environment Variables

Copy `.env.example` to `.env` or set these in your deployment platform:

### Backend (Render / Production)
| Variable | Description | Example |
|---|---|---|
| `DB_HOST` | PostgreSQL / Supabase Host | `db.fcthobeoyuugxrzruxlc.supabase.co` |
| `DB_PORT` | PostgreSQL Port | `5432` |
| `DB_NAME` | Database Name | `postgres` |
| `DB_USER` | Database User | `postgres` |
| `DB_PASSWORD` | Database Password | *(Your Supabase Password)* |
| `DB_SSLMODE` | SSL Mode (Mandatory for Supabase) | `require` |
| `JWT_SECRET` | 256-bit Secret Key for signing JWTs | *(Random 32+ char string)* |
| `CORS_ORIGIN` | Allowed Frontend Origin | `https://your-app.vercel.app` |
| `OPENWEATHER_API_KEY` | *(Optional)* OpenWeatherMap API Key | `your_api_key` |
| `MAIL_USERNAME` | *(Optional)* SMTP Email for reminders | `your_email@gmail.com` |
| `MAIL_PASSWORD` | *(Optional)* SMTP App Password | `your_app_password` |

### Frontend (Vercel)
| Variable | Description | Example |
|---|---|---|
| `NEXT_PUBLIC_API_URL` | Base URL of deployed Spring Boot backend | `https://tripnest-backend.onrender.com` |

---

## 🗄️ Database Setup (Supabase PostgreSQL)

TripNest uses versioned database migrations located in:
`tripnest-backend/src/main/resources/db/migration/`

1. Open your **Supabase Project** &rarr; **SQL Editor**.
2. Run the script in `V1__initial_schema.sql` to initialize all tables, relations, and indexes.
3. Run `V2__seed_initial_data.sql` to populate default roles and sample destinations.
4. When deployed with `SPRING_PROFILES_ACTIVE=prod`, Spring Boot validates the schema via `spring.jpa.hibernate.ddl-auto=validate`.

---

## 🚢 Deployment

### Deploy Backend on Render
1. Connect your repository to [Render](https://render.com).
2. Use the provided [`render.yaml`](./render.yaml) blueprint or create a Web Service:
   - **Environment**: Java
   - **Root Directory**: `tripnest-backend`
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -jar target/tripnest-backend-0.0.1-SNAPSHOT.jar`
3. Add the environment variables listed in the table above.

### Deploy Frontend on Vercel
1. Import the repository into [Vercel](https://vercel.com).
2. Set **Root Directory** to `frontend`.
3. Set the Framework Preset to **Next.js**.
4. Add `NEXT_PUBLIC_API_URL` pointing to your deployed Render backend.

---

## 🧪 Running Tests

Run backend unit and integration tests:
```powershell
cd tripnest-backend
.\mvnw.cmd test
```
The test suite defaults to the in-memory H2 profile via `@ActiveProfiles("dev")` for fast, zero-dependency test runs.

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](./LICENSE) file for details.

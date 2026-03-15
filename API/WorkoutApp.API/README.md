# WorkoutApp.API

## Purpose
WorkoutApp.API is an ASP.NET Core Web API for managing workout application data. It currently provides user-related endpoints and persists data in SQL Server using Entity Framework Core.

The API is configured to:
- Use SQL Server as the database provider.
- Apply EF Core migrations automatically on startup.
- Support local development and Docker-based development.

## Tech Stack
- .NET 10
- ASP.NET Core Web API
- Entity Framework Core 10
- SQL Server 2022 (Developer)
- Docker / Docker Compose

## Project Structure (High Level)
- `Program.cs`: app startup, service registration, DB provider setup, migration-on-startup.
- `Database/WorkoutAppDbContext.cs`: EF Core model mapping.
- `Database/Migrations/`: EF Core migration files.
- `Controllers/UserController.cs`: user endpoints.
- `docker-compose.yaml`: SQL Server + API multi-container setup.
- `User.http`: simple HTTP request examples.

## Prerequisites
Install the following:
- .NET 10 SDK
- Docker Desktop (Windows, with Linux containers)
- Optional: Visual Studio Code with C# extension

## Initial Setup (First Time)
1. Open a terminal in the project folder.
2. Restore dependencies:

```powershell
dotnet restore
```

3. Build the project:

```powershell
dotnet build
```

4. (Optional) Verify EF migrations exist:

```powershell
dotnet ef migrations list
```

If you do not have the EF CLI installed globally:

```powershell
dotnet tool install --global dotnet-ef
```

## Running the API

### Option A: Run with Docker Compose (recommended)
This starts SQL Server and the API together.

1. Start the stack:

```powershell
docker compose up --build -d
```

2. Confirm containers are healthy:

```powershell
docker ps
```

3. API base URL:
- `http://localhost:8003`

4. Stop the stack:

```powershell
docker compose down
```

5. Stop and remove DB volume (clean reset):

```powershell
docker compose down -v
```

### Option B: Run locally with dotnet
This expects SQL Server to be available on `localhost,14333` (for example via Docker SQL Server container).

1. Start only SQL Server (if needed):

```powershell
docker compose up -d sqlserver
```

2. Run the API:

```powershell
dotnet run
```

3. Local URLs (from launch settings):
- `http://localhost:5273`
- `https://localhost:7009`

## Database Configuration
Default connection string is configured for local SQL Server:

`Server=localhost,14333;Database=WorkoutAppDb;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=True;Encrypt=False`

You can override it with environment variable:

`ConnectionStrings__DefaultConnection`

Example:

```powershell
$env:ConnectionStrings__DefaultConnection = "Server=localhost,14333;Database=WorkoutAppDb;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=True;Encrypt=False"
```

## Migrations
The application applies pending migrations on startup (`db.Database.Migrate()`).

Create a new migration:

```powershell
dotnet ef migrations add <MigrationName> --output-dir Database/Migrations
```

Apply migrations manually:

```powershell
dotnet ef database update
```

## API Endpoints (Current)
Base route: `/api/User`

- `GET /api/User/email/{email}`
- `GET /api/User/{id}`
- `POST /api/User/`
- `PUT /api/User/{id}`
- `DELETE /api/User/{id}`

You can use `User.http` for quick API calls.

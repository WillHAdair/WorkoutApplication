using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Extensions;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services
    .AddSwagger()
    .AddServices();

// Configure EF Core with SQLite. Connection string comes from configuration
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
                       ?? builder.Configuration["ConnectionStrings:DefaultConnection"]
                       ?? "Data Source=workoutapp.db";
builder.Services.AddDbContext<WorkoutAppDbContext>(options =>
    options.UseSqlite(connectionString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

// Ensure database is created on startup (creates DB file/tables if missing)
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<WorkoutAppDbContext>();
    db.Database.EnsureCreated();
}

app.Run();

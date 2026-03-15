using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Respawn;
using Testcontainers.MsSql;
using WorkoutApp.API.Database;

namespace WorkoutApp.API.Test.TestInfrastructure;

public sealed class SqlServerContainerFixture : IAsyncLifetime
{
    private readonly string _databaseName = $"WorkoutAppTest_{Guid.NewGuid():N}";
    private readonly MsSqlContainer _container;
    private Respawner? _respawner;

    public SqlServerContainerFixture()
    {
        _container = new MsSqlBuilder()
            .WithImage("mcr.microsoft.com/mssql/server:2022-latest")
            .WithPassword("YourStrong!Passw0rd!")
            .Build();
    }

    public string ConnectionString { get; private set; } = string.Empty;

    public async Task InitializeAsync()
    {
        await _container.StartAsync();

        var connectionBuilder = new SqlConnectionStringBuilder(_container.GetConnectionString())
        {
            InitialCatalog = _databaseName,
            Encrypt = false,
            TrustServerCertificate = true
        };

        ConnectionString = connectionBuilder.ConnectionString;

        await using (var dbContext = CreateDbContext())
        {
            await dbContext.Database.MigrateAsync();
        }

        await using var connection = new SqlConnection(ConnectionString);
        await connection.OpenAsync();

        _respawner = await Respawner.CreateAsync(
            connection,
            new RespawnerOptions
            {
                DbAdapter = DbAdapter.SqlServer,
                SchemasToInclude = ["dbo"],
                TablesToIgnore = ["__EFMigrationsHistory"]
            });
    }

    public WorkoutAppDbContext CreateDbContext()
    {
        var options = new DbContextOptionsBuilder<WorkoutAppDbContext>()
            .UseSqlServer(ConnectionString)
            .Options;

        return new WorkoutAppDbContext(options);
    }

    public async Task ResetDatabaseAsync()
    {
        if (_respawner is null)
        {
            throw new InvalidOperationException("Database respawner has not been initialized.");
        }

        await using var connection = new SqlConnection(ConnectionString);
        await connection.OpenAsync();
        await _respawner.ResetAsync(connection);
    }

    public async Task DisposeAsync()
    {
        await _container.DisposeAsync();
    }
}

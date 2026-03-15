using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using WorkoutApp.API.Database;

namespace WorkoutApp.API.Test.TestInfrastructure;

public sealed class TestApiWebApplicationFactory(string connectionString) : WebApplicationFactory<Program>
{
    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.UseEnvironment("Testing");

        builder.ConfigureServices(services =>
        {
            services.RemoveAll(typeof(DbContextOptions<WorkoutAppDbContext>));

            services.AddDbContext<WorkoutAppDbContext>(options =>
                options.UseSqlServer(connectionString));
        });
    }
}

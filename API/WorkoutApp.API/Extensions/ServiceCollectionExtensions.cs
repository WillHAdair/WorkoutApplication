using WorkoutApp.API.Services;

namespace WorkoutApp.API.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddSwagger(this IServiceCollection services)
    {
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen();
        return services;
    }

    public static IServiceCollection AddServices(this IServiceCollection services)
    {
        services.AddScoped<IUserService, UserService>();
        services.AddScoped<IWorkoutScheduleService, WorkoutScheduleService>();
        services.AddScoped<IScheduleDayService, ScheduleDayService>();
        services.AddScoped<IExerciseService, ExerciseService>();
        services.AddScoped<IRepService, RepService>();
        return services;
    }
}
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using WorkoutApp.API.Models;

namespace WorkoutApp.API.Database;

public class WorkoutAppDbContext(DbContextOptions<WorkoutAppDbContext> options) : DbContext(options)
{

    // Core entity sets (include base types so queries can easily grab polymorphic data)
    public DbSet<User> Users { get; set; } = null!;
    public DbSet<WorkoutSchedule> WorkoutSchedules { get; set; } = null!;
    public DbSet<ScheduleDay> ScheduleDays { get; set; } = null!;
    public DbSet<Exercise> Exercises { get; set; } = null!;
    public DbSet<Rep> Reps { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            // Fallback SQL Server DB (used when DI/Program.cs hasn't configured the context)
            optionsBuilder.UseSqlServer("Server=localhost,14333;Database=WorkoutAppDb;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=True;Encrypt=False");
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Converters for date/time types used by this model.
        var dateOnlyConverter = new ValueConverter<DateOnly, DateTime>(
            d => d.ToDateTime(TimeOnly.MinValue),
            dt => DateOnly.FromDateTime(dt));

        var nullableDateOnlyConverter = new ValueConverter<DateOnly?, DateTime?>((
            d => d.HasValue ? d.Value.ToDateTime(TimeOnly.MinValue) : (DateTime?)null),
            dt => dt.HasValue ? DateOnly.FromDateTime(dt.Value) : (DateOnly?)null);

        var timeOnlyConverter = new ValueConverter<TimeOnly?, TimeSpan?>((
            t => t.HasValue ? t.Value.ToTimeSpan() : (TimeSpan?)null),
            ts => ts.HasValue ? TimeOnly.FromTimeSpan(ts.Value) : (TimeOnly?)null);

        // User -> WorkoutSchedules (one-to-many)
        modelBuilder.Entity<WorkoutSchedule>(b =>
        {
            b.HasOne(ws => ws.User)
             .WithMany()
             .HasForeignKey(ws => ws.UserId)
             .OnDelete(DeleteBehavior.Cascade);

            b.Property(ws => ws.StartDate).HasConversion(dateOnlyConverter);
            b.Property(ws => ws.EndDate).HasConversion(nullableDateOnlyConverter);
        });

        // WorkoutSchedule -> ScheduleDays (one-to-many)
        modelBuilder.Entity<WorkoutSchedule>(b =>
        {
            b.HasMany(s => s.ScheduleDays)
             .WithOne(sd => sd.WorkoutSchedule!)
             .HasForeignKey(sd => sd.WorkoutScheduleId)
             .OnDelete(DeleteBehavior.Cascade);
        });

        // ScheduleDay -> Exercises (one-to-many)
        modelBuilder.Entity<ScheduleDay>(b =>
        {
            b.HasMany(wd => wd.Exercises)
             .WithOne(we => we.ScheduleDay)
             .HasForeignKey(we => we.ScheduleDayId)
             .OnDelete(DeleteBehavior.Cascade);
        });

        // WorkoutExercise hierarchy (TPH)
        modelBuilder.Entity<Exercise>(b =>
        {
            b.ToTable("Exercises");
            b.HasDiscriminator<string>("ExerciseType")
             .HasValue<TimedExercise>("TimedWorkout")
             .HasValue<SetExercise>("SetExercise");

            // TimeOnly conversion for StartTime
            b.Property(e => e.StartTime).HasConversion(timeOnlyConverter);
        });

        modelBuilder.Entity<TimedExercise>(b => b.Property(e => e.Weight).HasPrecision(18, 2));

        // SetExercise -> Rep (one-to-many)
        modelBuilder.Entity<SetExercise>(b =>
        {
            b.HasMany(wse => wse.Sets)
             .WithOne(wr => wr.Exercise)
             .HasForeignKey(wr => wr.ExerciseId)
             .OnDelete(DeleteBehavior.Cascade);

            b.Property(wse => wse.RestPeriod).HasColumnType("time");
        });

        // WorkoutRepitition hierarchy (TPH)
        modelBuilder.Entity<Rep>(b =>
        {
            b.ToTable("Reps");
            b.HasDiscriminator<string>("RepititionType")
             .HasValue<TimedRep>("Timed")
             .HasValue<CountedRep>("Count")
             .HasValue<SuperSetRep>("SuperSet");

            b.Property(r => r.RestPeriod).HasColumnType("time");
        });

        modelBuilder.Entity<TimedRep>(b =>
        {
            b.Property(r => r.Duration).HasColumnType("time");
            b.Property(r => r.Weight).HasPrecision(18, 2);
        });

        modelBuilder.Entity<CountedRep>(b => b.Property(r => r.Weight).HasPrecision(18, 2));

        // SuperSetRep -> nested reps (one-to-many self relationship)
        modelBuilder.Entity<SuperSetRep>(b =>
        {
            b.HasMany(s => s.Exercises)
             .WithOne()
             .HasForeignKey("ParentSuperSetId")
             .OnDelete(DeleteBehavior.NoAction);
        });

        // Basic user mapping
        modelBuilder.Entity<User>(b =>
        {
            b.ToTable("Users");
            b.HasKey(u => u.Id);
            b.Property(u => u.Username).IsRequired();
            b.Property(u => u.Email).IsRequired();
            b.Property(u => u.PasswordHash).IsRequired();
        });

        // Ensure the common base entity primary key convention
        modelBuilder.Model.GetEntityTypes()
            .Where(t => typeof(BaseEntity).IsAssignableFrom(t.ClrType))
            .ToList()
            .ForEach(t => modelBuilder.Entity(t.ClrType).Property("Id").IsRequired());
    }
}

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using WorkoutApp.API.Models;

namespace WorkoutApp.API.Migrations;

public class WorkoutAppDbContext : DbContext
{
	public WorkoutAppDbContext(DbContextOptions<WorkoutAppDbContext> options) : base(options)
	{
	}

	// Core entity sets (include base types so queries can easily grab polymorphic data)
	public DbSet<User> Users { get; set; } = null!;
	public DbSet<WorkoutSchedule> WorkoutSchedules { get; set; } = null!;
	public DbSet<ScheduleDay> ScheduleDays { get; set; } = null!;
	public DbSet<WorkoutExercise> WorkoutExercises { get; set; } = null!;
	public DbSet<WorkoutRepitition> WorkoutRepititions { get; set; } = null!;

	protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
	{
		if (!optionsBuilder.IsConfigured)
		{
			// Fallback SQLite DB (used when DI/Program.cs hasn't configured the context)
			optionsBuilder.UseSqlite("Data Source=workoutapp.db");
		}
	}

	protected override void OnModelCreating(ModelBuilder modelBuilder)
	{
		// Converters for types SQLite doesn't handle natively
		var dateOnlyConverter = new ValueConverter<DateOnly, DateTime>(
			d => d.ToDateTime(TimeOnly.MinValue),
			dt => DateOnly.FromDateTime(dt));

		var nullableDateOnlyConverter = new ValueConverter<DateOnly?, DateTime?>(
			d => d.HasValue ? d.Value.ToDateTime(TimeOnly.MinValue) : (DateTime?)null,
			dt => dt.HasValue ? DateOnly.FromDateTime(dt.Value) : (DateOnly?)null);

		var timeOnlyConverter = new ValueConverter<TimeOnly?, TimeSpan?>(
			t => t.HasValue ? t.Value.ToTimeSpan() : (TimeSpan?)null,
			ts => ts.HasValue ? TimeOnly.FromTimeSpan(ts.Value) : (TimeOnly?)null);

		// WorkoutSchedule -> ScheduleDays (one-to-many)
		modelBuilder.Entity<WorkoutSchedule>(b =>
		{
			b.HasMany(s => s.ScheduleDays)
			 .WithOne(sd => sd.WorkoutSchedule!)
			 .HasForeignKey(sd => sd.WorkoutScheduleId)
			 .OnDelete(DeleteBehavior.Cascade);

			b.Property(ws => ws.StartDate).HasConversion(dateOnlyConverter);
			b.Property(ws => ws.EndDate).HasConversion(nullableDateOnlyConverter);
		});

		// ScheduleDay hierarchy (TPH)
		modelBuilder.Entity<ScheduleDay>(b =>
		{
			b.ToTable("ScheduleDays");
			b.HasDiscriminator<string>("ScheduleDayType")
			 .HasValue<RestDay>("Rest")
			 .HasValue<WorkoutDay>("Workout");
		});

		// WorkoutDay -> WorkoutExercises (one-to-many). WorkoutExercise doesn't carry a CLR FK, use shadow FK "WorkoutDayId".
		modelBuilder.Entity<WorkoutDay>(b =>
		{
			b.HasMany(wd => wd.WorkoutExercises)
			 .WithOne()
			 .HasForeignKey("WorkoutDayId")
			 .OnDelete(DeleteBehavior.Cascade);
		});

		// WorkoutExercise hierarchy (TPH)
		modelBuilder.Entity<WorkoutExercise>(b =>
		{
			b.ToTable("WorkoutExercises");
			b.HasDiscriminator<string>("ExerciseType")
			 .HasValue<TimedWorkout>("TimedWorkout")
			 .HasValue<WorkoutSetExercise>("SetExercise");

			// TimeOnly conversion for StartTime
			b.Property(e => e.StartTime).HasConversion(timeOnlyConverter);
		});

		// WorkoutSetExercise -> WorkoutRepitition (Sets)
		modelBuilder.Entity<WorkoutSetExercise>(b =>
		{
			b.HasMany(wse => wse.Sets)
			 .WithOne()
			 .HasForeignKey("WorkoutExerciseId")
			 .OnDelete(DeleteBehavior.Cascade);
		});

		// WorkoutRepitition hierarchy (TPH)
		modelBuilder.Entity<WorkoutRepitition>(b =>
		{
			b.ToTable("WorkoutRepititions");
			b.HasDiscriminator<string>("RepititionType")
			 .HasValue<TimedRepitition>("Timed")
			 .HasValue<RepetitionCount>("Count")
			 .HasValue<SuperSetRepition>("SuperSet");
		});

		// SuperSetRepition -> Exercises (one-to-many self relationship)
		modelBuilder.Entity<SuperSetRepition>(b =>
		{
			b.HasMany(s => s.Exercises)
			 .WithOne()
			 .HasForeignKey("ParentSuperSetId")
			 .OnDelete(DeleteBehavior.Cascade);
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

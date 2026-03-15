namespace WorkoutApp.API.Test.TestInfrastructure;

public sealed class ServiceResultEnvelope<T>
{
    public int StatusCode { get; set; }
    public string Message { get; set; } = string.Empty;
    public bool Success { get; set; }
    public T Data { get; set; } = default!;
}

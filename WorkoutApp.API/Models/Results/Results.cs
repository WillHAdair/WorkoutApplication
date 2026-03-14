namespace WorkoutApp.API.Models.Results;

// Base Result class
public abstract class ServiceResult
{
    public int StatusCode { get; set; }
    public string Message { get; set; }
    public object Data { get; set; }
}

public abstract class ServiceResult<T> : ServiceResult
{
    public new T Data { get; set; }
}

#region Success Results
/// <summary>
/// Represents a successful operation result with an optional message and data.
/// </summary>
public class SuccessResult : ServiceResult
{
    public SuccessResult(string message = "Success")
    {
        StatusCode = 200;
        Message = message;
    }
    public SuccessResult(object data, string message = "Success")
    {
        StatusCode = 200;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a successful operation result with an optional message and data.
/// </summary>
/// <typeparam name="T"></typeparam>
public class SuccessResult<T> : ServiceResult<T>
{
    public SuccessResult(T data, string message = "Success")
    {
        StatusCode = 200;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a created result with an optional message and data, indicating that a resource has been successfully created.
/// </summary>
public class CreatedResult : ServiceResult
{
    public CreatedResult(string message = "Created")
    {
        StatusCode = 201;
        Message = message;
    }

    public CreatedResult(object data, string message = "Created")
    {
        StatusCode = 201;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a created result with an optional message and data, indicating that a resource has been successfully created.
/// </summary>
/// <typeparam name="T"></typeparam>
public class CreatedResult<T> : ServiceResult<T>
{
    public CreatedResult(T data, string message = "Created")
    {
        StatusCode = 201;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a no content result with an optional message, indicating that the request was successful but there is no content to return.
/// </summary>
public class NoContentResult : ServiceResult
{
    public NoContentResult(string message = "No Content")
    {
        StatusCode = 204;
        Message = message;
    }
}

/// <summary>
/// Represents a no content result with an optional message, indicating that the request was successful but there is no content to return.
/// </summary>
/// <typeparam name="T"></typeparam>
public class NoContentResult<T> : ServiceResult<T>
{
    public NoContentResult(string message = "No Content")
    {
        StatusCode = 204;
        Message = message;
    }
}
#endregion

#region 400 level errors
/// <summary>
/// Represents a bad request result with an optional message and data, indicating that the server cannot process the request due to client error.
/// </summary>
public class BadRequestResult : ServiceResult
{
    public BadRequestResult(string message = "Bad Request")
    {
        StatusCode = 400;
        Message = message;
    }

    public BadRequestResult(object data, string message = "Bad Request")
    {
        StatusCode = 400;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a bad request result with an optional message and data, indicating that the server cannot process the request due to client error.
/// </summary>
/// <typeparam name="T"></typeparam>
public class BadRequestResult<T> : ServiceResult<T>
{
    public BadRequestResult(string message = "Bad Request")
    {
        StatusCode = 400;
        Message = message;
    }

    public BadRequestResult(T data, string message = "Bad Request")
    {
        StatusCode = 400;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents an unauthorized result with an optional message and data, indicating that the client is not authorized to access the requested resource.
/// </summary>
public class UnauthorizedResult : ServiceResult
{
    public UnauthorizedResult(string message = "Unauthorized")
    {
        StatusCode = 401;
        Message = message;
    }

    public UnauthorizedResult(object data, string message = "Unauthorized")
    {
        StatusCode = 401;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents an unauthorized result with an optional message and data, indicating that the client is not authorized to access the requested resource.
/// </summary>
/// <typeparam name="T"></typeparam>
public class UnauthorizedResult<T> : ServiceResult<T>
{
    public UnauthorizedResult(string message = "Unauthorized")
    {
        StatusCode = 401;
        Message = message;
    }

    public UnauthorizedResult(T data, string message = "Unauthorized")
    {
        StatusCode = 401;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a forbidden result with an optional message and data, indicating that the client is not authorized to access the requested resource.
/// </summary>
public class ForbiddenResult : ServiceResult
{
    public ForbiddenResult(string message = "Forbidden")
    {
        StatusCode = 403;
        Message = message;
    }

    public ForbiddenResult(object data, string message = "Forbidden")
    {
        StatusCode = 403;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a forbidden result with an optional message and data, indicating that the client is not authorized to access the requested resource.
/// </summary>
/// <typeparam name="T"></typeparam>
public class ForbiddenResult<T> : ServiceResult<T>
{
    public ForbiddenResult(string message = "Forbidden")
    {
        StatusCode = 403;
        Message = message;
    }

    public ForbiddenResult(T data, string message = "Forbidden")
    {
        StatusCode = 403;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a not found result with an optional message and data, indicating that the requested resource was not found.
/// </summary>
public class NotFoundResult : ServiceResult
{
    public NotFoundResult(string message = "Not Found")
    {
        StatusCode = 404;
        Message = message;
    }

    public NotFoundResult(object data, string message = "Not Found")
    {
        StatusCode = 404;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a not found result with an optional message and data, indicating that the requested resource was not found.
/// </summary>
/// <typeparam name="T"></typeparam>
public class NotFoundResult<T> : ServiceResult<T>
{
    public NotFoundResult(string message = "Not Found")
    {
        StatusCode = 404;
        Message = message;
    }

    public NotFoundResult(T data, string message = "Not Found")
    {
        StatusCode = 404;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a not allowed result with an optional message and data, indicating that the HTTP method used in the request is not allowed for the requested resource.
/// </summary>
public class NotAllowedResult : ServiceResult
{
    public NotAllowedResult(string message = "Method Not Allowed")
    {
        StatusCode = 405;
        Message = message;
    }

    public NotAllowedResult(object data, string message = "Method Not Allowed")
    {
        StatusCode = 405;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a not allowed result with an optional message and data, indicating that the HTTP method used in the request is not allowed for the requested resource.
/// </summary>
public class NotAllowedResult<T> : ServiceResult<T>
{
    public NotAllowedResult(string message = "Method Not Allowed")
    {
        StatusCode = 405;
        Message = message;
    }

    public NotAllowedResult(T data, string message = "Method Not Allowed")
    {
        StatusCode = 405;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a conflict result with an optional message and data, indicating that the request could not be completed due to a conflict with the current state of the resource.
/// </summary>
public class ConflictResult : ServiceResult
{
    public ConflictResult(string message = "Conflict")
    {
        StatusCode = 409;
        Message = message;
    }

    public ConflictResult(object data, string message = "Conflict")
    {
        StatusCode = 409;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a conflict result with an optional message and data, indicating that the request could not be completed due to a conflict with the current state of the resource.
/// </summary>
/// <typeparam name="T"></typeparam>
public class ConflictResult<T> : ServiceResult<T>
{
    public ConflictResult(string message = "Conflict")
    {
        StatusCode = 409;
        Message = message;
    }

    public ConflictResult(T data, string message = "Conflict")
    {
        StatusCode = 409;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents an unprocessable entity result with an optional message and data, indicating that the server understands the content type of the request entity, but was unable to process the contained instructions.
/// </summary>
public class UnprocessableEntityResult : ServiceResult
{
    public UnprocessableEntityResult(string message = "Unprocessable Entity")
    {
        StatusCode = 422;
        Message = message;
    }

    public UnprocessableEntityResult(object data, string message = "Unprocessable Entity")
    {
        StatusCode = 422;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents an unprocessable entity result with an optional message and data, indicating that the server understands the content type of the request entity, but was unable to process the contained instructions.
/// </summary>
/// <typeparam name="T"></typeparam>
public class UnprocessableEntityResult<T> : ServiceResult<T>
{
    public UnprocessableEntityResult(string message = "Unprocessable Entity")
    {
        StatusCode = 422;
        Message = message;
    }

    public UnprocessableEntityResult(T data, string message = "Unprocessable Entity")
    {
        StatusCode = 422;
        Message = message;
        Data = data;
    }
}
#endregion

#region 500 level errors
/// <summary>
/// Represents an internal server error result with an optional message and data, indicating that the server encountered an unexpected condition that prevented it from fulfilling the request.
/// </summary>
public class InternalServerErrorResult : ServiceResult
{
    public InternalServerErrorResult(string message = "Internal Server Error")
    {
        StatusCode = 500;
        Message = message;
    }

    public InternalServerErrorResult(object data, string message = "Internal Server Error")
    {
        StatusCode = 500;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents an internal server error result with an optional message and data, indicating that the server encountered an unexpected condition that prevented it from fulfilling the request.
/// </summary>
/// <typeparam name="T"></typeparam>
public class InternalServerErrorResult<T> : ServiceResult<T>
{
    public InternalServerErrorResult(string message = "Internal Server Error")
    {
        StatusCode = 500;
        Message = message;
    }

    public InternalServerErrorResult(T data, string message = "Internal Server Error")
    {
        StatusCode = 500;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a not implemented result with an optional message and data, indicating that the server does not support the functionality required to fulfill the request.
/// </summary>
public class NotImplementedResult : ServiceResult
{
    public NotImplementedResult(string message = "Not Implemented")
    {
        StatusCode = 501;
        Message = message;
    }

    public NotImplementedResult(object data, string message = "Not Implemented")
    {
        StatusCode = 501;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a not implemented result with an optional message and data, indicating that the server does not support the functionality required to fulfill the request.
/// </summary>
/// <typeparam name="T"></typeparam>
public class NotImplementedResult<T> : ServiceResult<T>
{
    public NotImplementedResult(string message = "Not Implemented")
    {
        StatusCode = 501;
        Message = message;
    }

    public NotImplementedResult(T data, string message = "Not Implemented")
    {
        StatusCode = 501;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a bad gateway result with an optional message and data, indicating that the server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.
/// </summary>
public class BadGatewayResult : ServiceResult
{
    public BadGatewayResult(string message = "Bad Gateway")
    {
        StatusCode = 502;
        Message = message;
    }

    public BadGatewayResult(object data, string message = "Bad Gateway")
    {
        StatusCode = 502;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a bad gateway result with an optional message and data, indicating that the server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.
/// </summary>
/// <typeparam name="T"></typeparam>
public class BadGatewayResult<T> : ServiceResult<T>
{
    public BadGatewayResult(string message = "Bad Gateway")
    {
        StatusCode = 502;
        Message = message;
    }

    public BadGatewayResult(T data, string message = "Bad Gateway")
    {
        StatusCode = 502;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a service unavailable result with an optional message and data, indicating that the server is currently unable to handle the request due to temporary overloading or maintenance of the server.
/// </summary>
public class ServiceUnavailableResult : ServiceResult
{
    public ServiceUnavailableResult(string message = "Service Unavailable")
    {
        StatusCode = 503;
        Message = message;
    }

    public ServiceUnavailableResult(object data, string message = "Service Unavailable")
    {
        StatusCode = 503;
        Message = message;
        Data = data;
    }
}

/// <summary>
/// Represents a service unavailable result with an optional message and data, indicating that the server is currently unable to handle the request due to temporary overloading or maintenance of the server.
/// </summary>
/// <typeparam name="T"></typeparam>
public class ServiceUnavailableResult<T> : ServiceResult<T>
{
    public ServiceUnavailableResult(string message = "Service Unavailable")
    {
        StatusCode = 503;
        Message = message;
    }

    public ServiceUnavailableResult(T data, string message = "Service Unavailable")
    {
        StatusCode = 503;
        Message = message;
        Data = data;
    }
}
#endregion

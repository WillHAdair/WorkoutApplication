import axios, { AxiosError, type AxiosRequestConfig } from "axios";
import type { ServiceResult } from "~/models/results";
import { formatForApi, parseFromApi } from "./Date.utils";

export interface RequestOptions<T> {
  method: "GET" | "POST" | "PUT" | "DELETE";
  controller:
    | "exercises"
    | "reps"
    | "scheduledays"
    | "users"
    | "workoutschedules";
  route?: string;
  queryParams?: Record<string, string | number | boolean>;
  routeParams?: Record<string, string | number>;
  body?: T;
  axiosOptions?: Omit<AxiosRequestConfig, "method" | "url" | "data">;
}

export default async function SendRequest<T>(
  options: RequestOptions<T>,
): Promise<ServiceResult<T>> {
  try {
    let {
      method,
      controller,
      route,
      queryParams,
      routeParams,
      body,
      axiosOptions,
    } = options;

    // Construct the URL with route parameters
    let url = `/api/${controller}`;
    if (route) {
      url += `/${route}`;
    }
    if (routeParams) {
      for (const [key, value] of Object.entries(routeParams)) {
        url = url.replace(`:${key}`, encodeURIComponent(String(value)));
      }
    }

    // Append query parameters
    if (queryParams) {
      const queryString = new URLSearchParams(
        Object.entries(queryParams).map(([key, value]) => [key, String(value)]),
      ).toString();
      url += `?${queryString}`;
    }

    if (body) {
      // Ensure the body is properly formatted for the API (e.g., dates to ISO strings)
      body = formatForApi(body);
    }

    const axiosResponse = await axios({
      method,
      url,
      data: body,
      ...axiosOptions,
    });

    // Transform the response data if necessary (e.g., parse dates)
    if (axiosResponse.data) {
      axiosResponse.data = parseFromApi(axiosResponse.data);
    }

    return axiosResponse.data as ServiceResult<T>;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      const axiosError = error as AxiosError;
      return Promise.reject({
        statusCode: axiosError.response?.status || 500,
        message: axiosError.message,
        success: false,
        data: axiosError.response?.data,
      } as ServiceResult<T>);
    }
    return Promise.reject({
      statusCode: 500,
      message: (error as Error).message || "An unknown error occurred",
      success: false,
    } as ServiceResult<T>);
  }
}

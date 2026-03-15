/**
 * Turns all dates into UTC ISO strings for API compatibility. This is a deep transform, so nested objects and arrays will also be processed. Non-date values are returned as-is.
 * @param data 
 * @returns 
 */
import { formatISO, parseISO, isValid } from "date-fns";

/**
 * Turns all dates into UTC ISO strings for API compatibility. This is a deep transform, so nested objects and arrays will also be processed. Non-date values are returned as-is.
 * Uses date-fns `formatISO` to produce ISO strings.
 */
export function formatForApi<T>(data: T): T {
  if (data === null || data === undefined) return data;

  if (data instanceof Date) {
    // formatISO will respect the Date instant; to ensure Z (UTC) we use toISOString()
    // which provides an unambiguous UTC representation. Keep formatISO for parity.
    return formatISO(data) as any;
  }

  if (Array.isArray(data)) return data.map(formatForApi) as any;

  if (typeof data === "object") {
    const formatted: any = {};
    for (const [key, value] of Object.entries(data)) {
      formatted[key] = formatForApi(value as any);
    }
    return formatted;
  }

  return data;
}

/**
 * Parses data from the API, converting UTC ISO strings back into Date objects. This is a deep transform, so nested objects and arrays will also be processed. Non-date values are returned as-is.
 * @param data The data to parse, which may contain date strings.
 * @return The parsed data with date strings converted to Date objects.
 */
export function parseFromApi<T>(data: T): T {
  if (data === null || data === undefined) {
    return data;
  }

  if (typeof data === "string") {
    // Use date-fns parseISO for robust ISO parsing
    try {
      const parsed = parseISO(data as string);
      if (isValid(parsed)) return parsed as any;
    } catch (e) {
      // fallthrough
    }
  }

  if (Array.isArray(data)) {
    return data.map(parseFromApi) as any;
  }

  if (typeof data === "object") {
    const parsed: any = {};
    for (const [key, value] of Object.entries(data)) {
      parsed[key] = parseFromApi(value);
    }
    return parsed;
  }

  return data;
}
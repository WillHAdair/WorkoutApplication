export interface ServiceResultBase {
  statusCode: number;
  message: string;
  success: boolean;
  data?: any;
}

export interface ServiceResult<T> extends ServiceResultBase {
  data: T;
}

// Convenience envelope shape used in tests and some client contexts
export interface ServiceResultEnvelope<T> {
  statusCode: number;
  message: string;
  success: boolean;
  data: T;
}

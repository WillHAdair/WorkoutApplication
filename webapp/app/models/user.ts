import type { NamedEntity } from "./base";

export enum MeasurementUnit {
  Imperial = "Imperial",
  Metric = "Metric",
}

export interface User extends NamedEntity {
  username: string;
  email: string;
  // Password hash only stored server-side; include for completeness but avoid using in client code.
  passwordHash?: string;
  baseUnit: MeasurementUnit;
}

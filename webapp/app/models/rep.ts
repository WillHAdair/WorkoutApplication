import type { NamedEntity } from "./base";

export enum RepititionMode {
  SuperSet = "SuperSet",
  DropSet = "DropSet",
}

export type RepDiscriminator = "timed" | "counted" | "superset";

export interface RepBase extends NamedEntity {
  exerciseId: string;
  restPeriod?: Date | null;
  $type?: RepDiscriminator;
}

export interface TimedRep extends RepBase {
  $type: "timed";
  duration: Date; // represented as Date for consistency
  weight?: number | null;
}

export interface CountedRep extends RepBase {
  $type: "counted";
  count?: number | null; // null indicates to-failure
  weight?: number | null;
}

export interface SuperSetRep extends RepBase {
  $type: "superset";
  exercises: Rep[];
  mode: RepititionMode;
}

export type Rep = TimedRep | CountedRep | SuperSetRep;

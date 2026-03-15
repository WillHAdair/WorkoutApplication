export interface BaseEntity {
  id: string; // GUID
  createdAt: Date;
  updatedAt: Date;
}

export interface NamedEntity extends BaseEntity {
  name: string;
  description?: string;
}

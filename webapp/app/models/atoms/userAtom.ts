import { atom } from "jotai";
import type { User } from "../user";

const userAtom = atom<User | null>(null);

export { userAtom };
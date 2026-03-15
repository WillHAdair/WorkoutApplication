import { createContext, useContext, useMemo, useState } from "react";

export type ThemeMode = "light" | "dark" | "system";
export type UnitPreference = "lb-mi" | "kg-km";

type AppPreferencesValue = {
  themeMode: ThemeMode;
  setThemeMode: (value: ThemeMode) => void;
  unitPreference: UnitPreference;
  setUnitPreference: (value: UnitPreference) => void;
  workoutRemindersEnabled: boolean;
  setWorkoutRemindersEnabled: (value: boolean) => void;
  completionNudgesEnabled: boolean;
  setCompletionNudgesEnabled: (value: boolean) => void;
};

const AppPreferencesContext = createContext<AppPreferencesValue | null>(null);

export function AppPreferencesProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [themeMode, setThemeMode] = useState<ThemeMode>("system");
  const [unitPreference, setUnitPreference] = useState<UnitPreference>("lb-mi");
  const [workoutRemindersEnabled, setWorkoutRemindersEnabled] = useState(true);
  const [completionNudgesEnabled, setCompletionNudgesEnabled] = useState(true);

  const value = useMemo(
    () => ({
      themeMode,
      setThemeMode,
      unitPreference,
      setUnitPreference,
      workoutRemindersEnabled,
      setWorkoutRemindersEnabled,
      completionNudgesEnabled,
      setCompletionNudgesEnabled,
    }),
    [
      themeMode,
      unitPreference,
      workoutRemindersEnabled,
      completionNudgesEnabled,
    ],
  );

  return (
    <AppPreferencesContext.Provider value={value}>
      {children}
    </AppPreferencesContext.Provider>
  );
}

export function useAppPreferences() {
  const context = useContext(AppPreferencesContext);
  if (!context) {
    throw new Error("useAppPreferences must be used inside AppPreferencesProvider");
  }

  return context;
}

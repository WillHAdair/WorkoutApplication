import DarkModeRoundedIcon from "@mui/icons-material/DarkModeRounded";
import NotificationsRoundedIcon from "@mui/icons-material/NotificationsRounded";
import StraightenRoundedIcon from "@mui/icons-material/StraightenRounded";
import {
  Box,
  Divider,
  FormControl,
  FormControlLabel,
  InputLabel,
  MenuItem,
  Paper,
  Select,
  Stack,
  Switch,
  Typography,
} from "@mui/material";

import { useAppPreferences } from "../context/app-preferences";

export default function Settings() {
  const {
    completionNudgesEnabled,
    setCompletionNudgesEnabled,
    setThemeMode,
    setUnitPreference,
    setWorkoutRemindersEnabled,
    themeMode,
    unitPreference,
    workoutRemindersEnabled,
  } = useAppPreferences();

  return (
    <Stack spacing={3}>
      <Box>
        <Typography variant="h3">Settings</Typography>
        <Typography color="text.secondary">
          Customize units, reminders, and app theme from one place.
        </Typography>
      </Box>

      <Paper sx={{ p: 2.5 }}>
        <Stack spacing={2.5}>
          <Stack direction="row" spacing={1.5}>
            <StraightenRoundedIcon color="primary" />
            <Box sx={{ flex: 1 }}>
              <Typography variant="h6">Units</Typography>
              <Typography color="text.secondary" variant="body2">
                Choose your preferred tracking units for weight and distance.
              </Typography>
              <FormControl fullWidth sx={{ mt: 1.5 }}>
                <InputLabel id="units-select-label">Unit System</InputLabel>
                <Select
                  label="Unit System"
                  labelId="units-select-label"
                  onChange={(event) => setUnitPreference(event.target.value as "lb-mi" | "kg-km")}
                  value={unitPreference}
                >
                  <MenuItem value="lb-mi">Imperial (lb, mi)</MenuItem>
                  <MenuItem value="kg-km">Metric (kg, km)</MenuItem>
                </Select>
              </FormControl>
            </Box>
          </Stack>

          <Divider />

          <Stack direction="row" spacing={1.5}>
            <NotificationsRoundedIcon color="primary" />
            <Box sx={{ flex: 1 }}>
              <Typography variant="h6">Notifications</Typography>
              <Typography color="text.secondary" variant="body2">
                Keep gentle reminders enabled so workouts stay consistent.
              </Typography>
              <FormControlLabel
                control={
                  <Switch
                    checked={workoutRemindersEnabled}
                    onChange={(event) => setWorkoutRemindersEnabled(event.target.checked)}
                  />
                }
                label="Workout reminders"
              />
              <FormControlLabel
                control={
                  <Switch
                    checked={completionNudgesEnabled}
                    onChange={(event) => setCompletionNudgesEnabled(event.target.checked)}
                  />
                }
                label="Completion nudges"
              />
            </Box>
          </Stack>

          <Divider />

          <Stack direction="row" spacing={1.5}>
            <DarkModeRoundedIcon color="primary" />
            <Box sx={{ flex: 1 }}>
              <Typography variant="h6">Theme</Typography>
              <Typography color="text.secondary" variant="body2">
                Pick a display style that fits your training environment.
              </Typography>
              <FormControl fullWidth sx={{ mt: 1.5 }}>
                <InputLabel id="theme-select-label">Theme Mode</InputLabel>
                <Select
                  label="Theme Mode"
                  labelId="theme-select-label"
                  onChange={(event) =>
                    setThemeMode(event.target.value as "light" | "dark" | "system")
                  }
                  value={themeMode}
                >
                  <MenuItem value="light">Light</MenuItem>
                  <MenuItem value="dark">Dark</MenuItem>
                  <MenuItem value="system">System</MenuItem>
                </Select>
              </FormControl>
            </Box>
          </Stack>
        </Stack>
      </Paper>
    </Stack>
  );
}

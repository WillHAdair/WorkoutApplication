import CalendarMonthRoundedIcon from "@mui/icons-material/CalendarMonthRounded";
import SaveRoundedIcon from "@mui/icons-material/SaveRounded";
import {
  Alert,
  Box,
  Button,
  Chip,
  List,
  ListItemButton,
  ListItemText,
  Paper,
  Stack,
  Typography,
} from "@mui/material";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DateCalendar } from "@mui/x-date-pickers/DateCalendar";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import dayjs, { type Dayjs } from "dayjs";
import { useMemo, useState } from "react";

import { scheduleTemplates } from "../data/mock-workouts";

function formatDate(value: Dayjs) {
  return value.format("YYYY-MM-DD");
}

export default function Schedules() {
  const [selectedScheduleId, setSelectedScheduleId] = useState(scheduleTemplates[0].id);
  const [saved, setSaved] = useState(false);
  const [assignedDateMap, setAssignedDateMap] = useState<Record<string, Date[]>>(
    Object.fromEntries(scheduleTemplates.map((item) => [item.id, item.assignedDates])),
  );

  const selectedSchedule = useMemo(
    () => scheduleTemplates.find((item) => item.id === selectedScheduleId) ?? scheduleTemplates[0],
    [selectedScheduleId],
  );

  const assignedDates = assignedDateMap[selectedSchedule.id] ?? [];

  const toggleDate = (value: Dayjs) => {
    const dateObj = value.toDate();
    setSaved(false);
    setAssignedDateMap((current) => {
      const dates = current[selectedSchedule.id] ?? [];
      const exists = dates.some((d) => d.getTime() === dateObj.getTime());
      const nextDates = exists ? dates.filter((d) => d.getTime() !== dateObj.getTime()) : [...dates, dateObj];

      nextDates.sort((a, b) => a.getTime() - b.getTime());

      return {
        ...current,
        [selectedSchedule.id]: nextDates,
      };
    });
  };

  return (
    <Stack spacing={3}>
      <Box>
        <Typography variant="h3">Schedule Builder</Typography>
        <Typography color="text.secondary">
          Pick a workout schedule, then select calendar dates for when it should appear.
        </Typography>
      </Box>

      <Stack direction={{ xs: "column", md: "row" }} spacing={2.5}>
        <Paper sx={{ p: 2, width: { xs: "100%", md: 320 } }}>
          <Typography sx={{ mb: 1.5 }} variant="h6">
            Workout Schedules
          </Typography>
          <List>
            {scheduleTemplates.map((schedule) => (
              <ListItemButton
                key={schedule.id}
                onClick={() => setSelectedScheduleId(schedule.id)}
                selected={schedule.id === selectedSchedule.id}
              >
                <ListItemText primary={schedule.name} secondary={schedule.description} />
              </ListItemButton>
            ))}
          </List>
        </Paper>

        <Paper sx={{ p: 2, flex: 1 }}>
          <Stack direction="row" justifyContent="space-between" sx={{ mb: 1.5 }}>
            <Box>
              <Typography variant="h6">{selectedSchedule.name}</Typography>
              <Typography color="text.secondary" variant="body2">
                Click any date to assign or remove this schedule.
              </Typography>
            </Box>
            <CalendarMonthRoundedIcon color="primary" />
          </Stack>

          <LocalizationProvider dateAdapter={AdapterDayjs}>
            <DateCalendar
              onChange={(value) => {
                if (value) {
                  toggleDate(value);
                }
              }}
              value={assignedDates[0] ? dayjs(assignedDates[0]) : dayjs()}
            />
          </LocalizationProvider>

          <Stack direction="row" flexWrap="wrap" gap={1} sx={{ mt: 2 }}>
            {assignedDates.length > 0 ? (
              assignedDates.map((date) => (
                <Chip key={date.toISOString()} label={dayjs(date).format("ddd, MMM D")} />
              ))
            ) : (
              <Typography color="text.secondary">No dates selected yet.</Typography>
            )}
          </Stack>

          <Button
            onClick={() => setSaved(true)}
            startIcon={<SaveRoundedIcon />}
            sx={{ mt: 2 }}
            variant="contained"
          >
            Save Schedule Days
          </Button>

          {saved ? (
            <Alert sx={{ mt: 2 }} severity="success">
              Schedule days saved for {selectedSchedule.name}.
            </Alert>
          ) : null}
        </Paper>
      </Stack>
    </Stack>
  );
}

import AccessTimeRoundedIcon from "@mui/icons-material/AccessTimeRounded";
import EditCalendarRoundedIcon from "@mui/icons-material/EditCalendarRounded";
import FitnessCenterRoundedIcon from "@mui/icons-material/FitnessCenterRounded";
import PlayCircleRoundedIcon from "@mui/icons-material/PlayCircleRounded";
import {
  Box,
  Button,
  Card,
  CardContent,
  Chip,
  Grid,
  Stack,
  Typography,
} from "@mui/material";
import { Link } from "react-router";

import { todayWorkoutCards } from "../data/mock-workouts";

export function meta() {
  return [
    { title: "LiftLine | Today" },
    { name: "description", content: "Your workouts for today." },
  ];
}

function timeToMinutes(time?: string) {
  if (!time) {
    return Number.MAX_SAFE_INTEGER;
  }

  const [hours, minutes] = time.split(":").map(Number);
  return hours * 60 + minutes;
}

export default function Home() {
  const sortedWorkouts = [...todayWorkoutCards].sort(
    (a, b) => timeToMinutes(a.timeOfDay) - timeToMinutes(b.timeOfDay),
  );

  return (
    <Stack spacing={3}>
      <Box>
        <Typography variant="h3">Today&apos;s Training</Typography>
        <Typography color="text.secondary" variant="body1">
          Sunday, March 15 • You have {sortedWorkouts.length} active workouts scheduled.
        </Typography>
      </Box>

      <Grid container spacing={2.5}>
        {sortedWorkouts.map((workout) => (
          <Grid key={workout.id} size={{ xs: 12, md: 6 }}>
            <Card sx={{ height: "100%" }}>
              <CardContent>
                <Stack spacing={1.5}>
                  <Stack direction="row" justifyContent="space-between" spacing={1}>
                    <Chip icon={<FitnessCenterRoundedIcon />} label={workout.scheduleName} size="small" />
                    {workout.timeOfDay ? (
                      <Chip icon={<AccessTimeRoundedIcon />} label={workout.timeOfDay} size="small" />
                    ) : (
                      <Chip label="No set time" size="small" />
                    )}
                  </Stack>

                  <Typography variant="h5">{workout.name}</Typography>
                  <Typography color="text.secondary">
                    {workout.exerciseCount} exercises planned. Keep transitions smooth and form-focused.
                  </Typography>

                  <Stack direction="row" spacing={1.5}>
                    <Button component={Link} startIcon={<PlayCircleRoundedIcon />} to="/workouts" variant="contained">
                      Start
                    </Button>
                    <Button
                      component={Link}
                      startIcon={<EditCalendarRoundedIcon />}
                      to="/schedules"
                      variant="outlined"
                    >
                      Edit Schedule
                    </Button>
                  </Stack>
                </Stack>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </Stack>
  );
}

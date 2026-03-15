import AddRoundedIcon from "@mui/icons-material/AddRounded";
import ArrowForwardRoundedIcon from "@mui/icons-material/ArrowForwardRounded";
import CheckRoundedIcon from "@mui/icons-material/CheckRounded";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Button,
  Dialog,
  DialogContent,
  DialogTitle,
  InputAdornment,
  Stack,
  Step,
  StepLabel,
  Stepper,
  TextField,
  Typography,
} from "@mui/material";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faDumbbell,
  faHashtag,
  faLayerGroup,
  faNoteSticky,
  faStopwatch,
  faWeightHanging,
} from "@fortawesome/free-solid-svg-icons";
import { useState } from "react";

import { workoutExercises } from "../data/mock-workouts";

const exerciseSteps = ["Basics", "Guidance", "Confirm"];
const repSteps = ["Rep Pattern", "Intensity", "Confirm"];

export default function Workouts() {
  const [exerciseWizardOpen, setExerciseWizardOpen] = useState(false);
  const [repWizardOpen, setRepWizardOpen] = useState(false);
  const [exerciseStep, setExerciseStep] = useState(0);
  const [repStep, setRepStep] = useState(0);

  const [exerciseForm, setExerciseForm] = useState({
    name: "Dumbbell Row",
    category: "Pull",
    cues: "Pull elbow toward hip and pause for control.",
  });

  const [repForm, setRepForm] = useState({
    sets: "3",
    reps: "10",
    weight: "50",
    rest: "75",
  });

  return (
    <Stack spacing={3}>
      <Box>
        <Typography variant="h3">Workout Builder</Typography>
        <Typography color="text.secondary">
          Track your exercises and reps with guided pop-ups designed for a beginner-friendly flow.
        </Typography>
      </Box>

      <Stack direction={{ xs: "column", sm: "row" }} spacing={1.5}>
        <Button
          onClick={() => {
            setExerciseStep(0);
            setExerciseWizardOpen(true);
          }}
          startIcon={<AddRoundedIcon />}
          variant="contained"
        >
          Add Exercise
        </Button>
        <Button
          onClick={() => {
            setRepStep(0);
            setRepWizardOpen(true);
          }}
          startIcon={<AddRoundedIcon />}
          variant="outlined"
        >
          Add Reps
        </Button>
      </Stack>

      <Stack spacing={1.5}>
        {workoutExercises.map((exercise) => (
          <Accordion key={exercise.id}>
            <AccordionSummary aria-controls={`${exercise.id}-content`} id={`${exercise.id}-header`}>
              <Stack direction="row" justifyContent="space-between" sx={{ width: "100%" }}>
                <Typography variant="h6">{exercise.name}</Typography>
                <Typography color="text.secondary">{exercise.repsSummary}</Typography>
              </Stack>
            </AccordionSummary>
            <AccordionDetails>
              <Typography sx={{ mb: 1.5 }}>
                <strong>Category:</strong> {exercise.category}
              </Typography>
              <Typography color="text.secondary">{exercise.cues}</Typography>
            </AccordionDetails>
          </Accordion>
        ))}
      </Stack>

      <Dialog fullWidth maxWidth="sm" onClose={() => setExerciseWizardOpen(false)} open={exerciseWizardOpen}>
        <DialogTitle>Add Exercise</DialogTitle>
        <DialogContent>
          <Stack spacing={2.5} sx={{ py: 1 }}>
            <Stepper activeStep={exerciseStep}>
              {exerciseSteps.map((step) => (
                <Step key={step}>
                  <StepLabel>{step}</StepLabel>
                </Step>
              ))}
            </Stepper>

            {exerciseStep === 0 ? (
              <Stack spacing={2}>
                <TextField
                  label="Exercise Name"
                  onChange={(event) =>
                    setExerciseForm((current) => ({ ...current, name: event.target.value }))
                  }
                  value={exerciseForm.name}
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <FontAwesomeIcon icon={faDumbbell} />
                      </InputAdornment>
                    ),
                  }}
                />
                <TextField
                  label="Category"
                  onChange={(event) =>
                    setExerciseForm((current) => ({ ...current, category: event.target.value }))
                  }
                  value={exerciseForm.category}
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <FontAwesomeIcon icon={faLayerGroup} />
                      </InputAdornment>
                    ),
                  }}
                />
              </Stack>
            ) : null}

            {exerciseStep === 1 ? (
              <TextField
                helperText="Add clear coaching cues for safer reps."
                label="Coaching Cues"
                minRows={3}
                multiline
                onChange={(event) =>
                  setExerciseForm((current) => ({ ...current, cues: event.target.value }))
                }
                value={exerciseForm.cues}
                InputProps={{
                  startAdornment: (
                    <InputAdornment position="start">
                      <FontAwesomeIcon icon={faNoteSticky} />
                    </InputAdornment>
                  ),
                }}
              />
            ) : null}

            {exerciseStep === 2 ? (
              <Box>
                <Typography variant="subtitle1">Review</Typography>
                <Typography>Name: {exerciseForm.name}</Typography>
                <Typography>Category: {exerciseForm.category}</Typography>
                <Typography color="text.secondary">Cues: {exerciseForm.cues}</Typography>
              </Box>
            ) : null}

            <Stack direction="row" justifyContent="space-between">
              <Button onClick={() => setExerciseWizardOpen(false)}>Cancel</Button>
              {exerciseStep < exerciseSteps.length - 1 ? (
                <Button
                  endIcon={<ArrowForwardRoundedIcon />}
                  onClick={() => setExerciseStep((value) => value + 1)}
                  variant="contained"
                >
                  Continue
                </Button>
              ) : (
                <Button
                  endIcon={<CheckRoundedIcon />}
                  onClick={() => setExerciseWizardOpen(false)}
                  variant="contained"
                >
                  Add Exercise
                </Button>
              )}
            </Stack>
          </Stack>
        </DialogContent>
      </Dialog>

      <Dialog fullWidth maxWidth="sm" onClose={() => setRepWizardOpen(false)} open={repWizardOpen}>
        <DialogTitle>Add Reps</DialogTitle>
        <DialogContent>
          <Stack spacing={2.5} sx={{ py: 1 }}>
            <Stepper activeStep={repStep}>
              {repSteps.map((step) => (
                <Step key={step}>
                  <StepLabel>{step}</StepLabel>
                </Step>
              ))}
            </Stepper>

            {repStep === 0 ? (
              <Stack direction={{ xs: "column", sm: "row" }} spacing={2}>
                <TextField
                  label="Sets"
                  onChange={(event) => setRepForm((current) => ({ ...current, sets: event.target.value }))}
                  value={repForm.sets}
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <FontAwesomeIcon icon={faLayerGroup} />
                      </InputAdornment>
                    ),
                  }}
                />
                <TextField
                  label="Reps"
                  onChange={(event) => setRepForm((current) => ({ ...current, reps: event.target.value }))}
                  value={repForm.reps}
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <FontAwesomeIcon icon={faHashtag} />
                      </InputAdornment>
                    ),
                  }}
                />
              </Stack>
            ) : null}

            {repStep === 1 ? (
              <Stack direction={{ xs: "column", sm: "row" }} spacing={2}>
                <TextField
                  label="Weight"
                  onChange={(event) =>
                    setRepForm((current) => ({ ...current, weight: event.target.value }))
                  }
                  value={repForm.weight}
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <FontAwesomeIcon icon={faWeightHanging} />
                      </InputAdornment>
                    ),
                  }}
                />
                <TextField
                  label="Rest (seconds)"
                  onChange={(event) => setRepForm((current) => ({ ...current, rest: event.target.value }))}
                  value={repForm.rest}
                  InputProps={{
                    startAdornment: (
                      <InputAdornment position="start">
                        <FontAwesomeIcon icon={faStopwatch} />
                      </InputAdornment>
                    ),
                  }}
                />
              </Stack>
            ) : null}

            {repStep === 2 ? (
              <Box>
                <Typography variant="subtitle1">Review</Typography>
                <Typography>
                  {repForm.sets} sets x {repForm.reps} reps
                </Typography>
                <Typography>
                  {repForm.weight} lb with {repForm.rest}s rest
                </Typography>
              </Box>
            ) : null}

            <Stack direction="row" justifyContent="space-between">
              <Button onClick={() => setRepWizardOpen(false)}>Cancel</Button>
              {repStep < repSteps.length - 1 ? (
                <Button
                  endIcon={<ArrowForwardRoundedIcon />}
                  onClick={() => setRepStep((value) => value + 1)}
                  variant="contained"
                >
                  Continue
                </Button>
              ) : (
                <Button endIcon={<CheckRoundedIcon />} onClick={() => setRepWizardOpen(false)} variant="contained">
                  Save Reps
                </Button>
              )}
            </Stack>
          </Stack>
        </DialogContent>
      </Dialog>
    </Stack>
  );
}

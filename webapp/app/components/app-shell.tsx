import MenuIcon from "@mui/icons-material/Menu";
import {
  AppBar,
  Box,
  Container,
  Drawer,
  IconButton,
  List,
  ListItemButton,
  ListItemText,
  Toolbar,
  Typography,
} from "@mui/material";
import { useMemo, useState } from "react";
import { Link as RouterLink, useLocation } from "react-router";

const navItems = [
  { label: "Home", path: "/" },
  { label: "Schedule", path: "/schedules" },
  { label: "Workouts", path: "/workouts" },
  { label: "Settings", path: "/settings" },
];

export function AppShell({ children }: { children: React.ReactNode }) {
  const [drawerOpen, setDrawerOpen] = useState(false);
  const location = useLocation();

  const activeTitle = useMemo(
    () => navItems.find((item) => item.path === location.pathname)?.label ?? "Workout",
    [location.pathname],
  );

  return (
    <Box sx={{ minHeight: "100vh", bgcolor: "background.default" }}>
      <AppBar
        position="fixed"
        color="transparent"
        elevation={0}
        sx={{ borderBottom: "1px solid", borderColor: "divider", backdropFilter: "blur(8px)" }}
      >
        <Toolbar>
          <Typography
            component="div"
            sx={{ flexGrow: 1, fontFamily: "'Barlow Condensed', sans-serif", letterSpacing: 1 }}
            variant="h5"
          >
            LiftLine
          </Typography>
          <Typography sx={{ mr: 2 }} variant="subtitle1">
            {activeTitle}
          </Typography>
          <IconButton
            aria-label="open navigation"
            color="inherit"
            edge="end"
            onClick={() => setDrawerOpen(true)}
          >
            <MenuIcon />
          </IconButton>
        </Toolbar>
      </AppBar>

      <Drawer anchor="right" onClose={() => setDrawerOpen(false)} open={drawerOpen}>
        <Box role="presentation" sx={{ width: 280 }}>
          <Box sx={{ px: 2, py: 3 }}>
            <Typography
              sx={{ fontFamily: "'Barlow Condensed', sans-serif", letterSpacing: 1 }}
              variant="h5"
            >
              Navigate
            </Typography>
          </Box>
          <List>
            {navItems.map((item) => (
              <ListItemButton
                component={RouterLink}
                key={item.path}
                onClick={() => setDrawerOpen(false)}
                selected={item.path === location.pathname}
                to={item.path}
              >
                <ListItemText primary={item.label} />
              </ListItemButton>
            ))}
          </List>
        </Box>
      </Drawer>

      <Container sx={{ pt: 12, pb: 6 }} maxWidth="lg">
        {children}
      </Container>
    </Box>
  );
}

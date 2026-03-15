import MenuIcon from "@mui/icons-material/Menu";
import HomeRoundedIcon from "@mui/icons-material/HomeRounded";
import CalendarMonthRoundedIcon from "@mui/icons-material/CalendarMonthRounded";
import FitnessCenterRoundedIcon from "@mui/icons-material/FitnessCenterRounded";
import SettingsRoundedIcon from "@mui/icons-material/SettingsRounded";
import ChevronLeftRoundedIcon from "@mui/icons-material/ChevronLeftRounded";
import ChevronRightRoundedIcon from "@mui/icons-material/ChevronRightRounded";
import {
  AppBar,
  Box,
  Container,
  Divider,
  Drawer,
  IconButton,
  List,
  ListItemButton,
  ListItemText,
  Toolbar,
  Typography,
  useTheme,
} from "@mui/material";
import { useMemo, useState } from "react";
import { Link as RouterLink, useLocation } from "react-router";

const navItems = [
  { label: "Home", path: "/", icon: <HomeRoundedIcon /> },
  { label: "Schedule", path: "/schedules", icon: <CalendarMonthRoundedIcon /> },
  { label: "Workouts", path: "/workouts", icon: <FitnessCenterRoundedIcon /> },
  { label: "Settings", path: "/settings", icon: <SettingsRoundedIcon /> },
];

export function AppShell({ children }: { children: React.ReactNode }) {
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [collapsed, setCollapsed] = useState(false);
  const location = useLocation();
  const theme = useTheme();

  const activeTitle = useMemo(
    () => navItems.find((item) => item.path === location.pathname)?.label ?? "Workout",
    [location.pathname],
  );

  const drawerWidth = 280;
  const collapsedWidth = 80;
  const currentDrawerWidth = collapsed ? collapsedWidth : drawerWidth;

  return (
    <Box sx={{ display: "flex", minHeight: "100vh", bgcolor: "background.default" }}>
      {/* Top app bar only visible on small screens to open the drawer */}
      <AppBar
        position="fixed"
        color="transparent"
        elevation={0}
        sx={{ display: { md: "none" }, borderBottom: "1px solid", borderColor: "divider" }}
      >
        <Toolbar>
          <Typography
            component="div"
            sx={{ flexGrow: 1, fontFamily: "'Barlow Condensed', sans-serif", letterSpacing: 1 }}
            variant="h6"
          >
            LiftLine
          </Typography>
          <IconButton aria-label="open navigation" color="inherit" onClick={() => setDrawerOpen(true)}>
            <MenuIcon />
          </IconButton>
        </Toolbar>
      </AppBar>

      {/* Permanent drawer on md+; temporary on small screens */}
      <Drawer
        variant="temporary"
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        ModalProps={{ keepMounted: true }}
        sx={{ display: { xs: "block", md: "none" }, '& .MuiDrawer-paper': { width: drawerWidth } }}
      >
        <Box sx={{ px: 2, py: 3 }}>
          <Typography sx={{ fontFamily: "'Barlow Condensed', sans-serif", letterSpacing: 1 }} variant="h5">
            Navigate
          </Typography>
        </Box>
        <Divider />
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
      </Drawer>

      <Drawer
        variant="permanent"
        sx={{
          display: { xs: "none", md: "block" },
          '& .MuiDrawer-paper': {
            width: currentDrawerWidth,
            boxSizing: 'border-box',
            bgcolor: theme.palette.background.paper,
            transition: theme.transitions.create('width', { duration: 200 }),
            overflowX: 'hidden',
          },
        }}
        open
      >
        <Box sx={{ display: 'flex', alignItems: 'center', px: 2, py: 2 }}>
          <Box sx={{ flex: 1 }}>
            <Typography
              noWrap
              sx={{ fontFamily: "'Barlow Condensed', sans-serif", letterSpacing: 1, pl: collapsed ? 0 : 1 }}
              variant={collapsed ? 'h6' : 'h4'}
            >
              {collapsed ? 'LL' : 'LiftLine'}
            </Typography>
          </Box>
          <IconButton
            onClick={() => setCollapsed((s) => !s)}
            size="small"
            aria-label={collapsed ? 'Expand menu' : 'Collapse menu'}
          >
            {collapsed ? <ChevronRightRoundedIcon /> : <ChevronLeftRoundedIcon />}
          </IconButton>
        </Box>
        <Divider />
        <List>
          {navItems.map((item) => (
            <ListItemButton
              component={RouterLink}
              key={item.path}
              selected={item.path === location.pathname}
              to={item.path}
              sx={{ justifyContent: collapsed ? 'center' : 'flex-start', px: collapsed ? 1 : 2 }}
            >
              <Box sx={{ display: 'inline-flex', alignItems: 'center', mr: collapsed ? 0 : 2 }}>{item.icon}</Box>
              {!collapsed && <ListItemText primary={item.label} />}
            </ListItemButton>
          ))}
        </List>
      </Drawer>

      <Box component="main" sx={{ flex: 1, p: 3, width: { md: `calc(100% - ${currentDrawerWidth}px)` } }}>
        {/* add top spacing to account for the small-screen AppBar */}
        <Box sx={{ pt: { xs: 8, md: 0 } }}>
          <Container maxWidth="lg">{children}</Container>
        </Box>
      </Box>
    </Box>
  );
}

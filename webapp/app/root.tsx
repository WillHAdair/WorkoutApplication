import {
  CssBaseline,
  ThemeProvider,
  createTheme,
  responsiveFontSizes,
} from "@mui/material";
import {
  isRouteErrorResponse,
  Links,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
} from "react-router";
import { useMemo } from "react";

import { AppShell } from "./components/app-shell";
import {
  AppPreferencesProvider,
  useAppPreferences,
} from "./context/app-preferences";
import type { Route } from "./+types/root";
import "./app.css";

export const links: Route.LinksFunction = () => [
  { rel: "preconnect", href: "https://fonts.googleapis.com" },
  {
    rel: "preconnect",
    href: "https://fonts.gstatic.com",
    crossOrigin: "anonymous",
  },
  {
    rel: "stylesheet",
    href: "https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@400;600;700&family=Source+Sans+3:wght@400;500;600;700&display=swap",
  },
];

export function Layout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <Meta />
        <Links />
      </head>
      <body>
        {children}
        <ScrollRestoration />
        <Scripts />
      </body>
    </html>
  );
}

export default function App() {
  return (
    <AppPreferencesProvider>
      <AppThemeBoundary>
        <AppShell>
          <Outlet />
        </AppShell>
      </AppThemeBoundary>
    </AppPreferencesProvider>
  );
}

function AppThemeBoundary({ children }: { children: React.ReactNode }) {
  const { themeMode } = useAppPreferences();

  const resolvedMode = useMemo(() => {
    if (themeMode !== "system") {
      return themeMode;
    }

    if (
      typeof window !== "undefined" &&
      window.matchMedia("(prefers-color-scheme: dark)").matches
    ) {
      return "dark";
    }

    return "light";
  }, [themeMode]);

  const theme = useMemo(
    () =>
      responsiveFontSizes(
        createTheme({
          palette: {
            mode: resolvedMode,
            primary: { main: "#b9511c" },
            secondary: { main: "#0f6d61" },
            background: {
              default: resolvedMode === "dark" ? "#141414" : "#f6f3ee",
              paper: resolvedMode === "dark" ? "#222" : "#ffffff",
            },
          },
          shape: { borderRadius: 14 },
          typography: {
            fontFamily: "'Source Sans 3', sans-serif",
            h1: { fontFamily: "'Barlow Condensed', sans-serif", fontWeight: 700 },
            h2: { fontFamily: "'Barlow Condensed', sans-serif", fontWeight: 700 },
            h3: { fontFamily: "'Barlow Condensed', sans-serif", fontWeight: 700 },
            h4: { fontFamily: "'Barlow Condensed', sans-serif", fontWeight: 700 },
            h5: { fontFamily: "'Barlow Condensed', sans-serif", fontWeight: 700 },
            h6: { fontFamily: "'Barlow Condensed', sans-serif", fontWeight: 700 },
          },
        }),
      ),
    [resolvedMode],
  );

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      {children}
    </ThemeProvider>
  );
}

export function ErrorBoundary({ error }: Route.ErrorBoundaryProps) {
  let message = "Oops!";
  let details = "An unexpected error occurred.";
  let stack: string | undefined;

  if (isRouteErrorResponse(error)) {
    message = error.status === 404 ? "404" : "Error";
    details =
      error.status === 404
        ? "The requested page could not be found."
        : error.statusText || details;
  } else if (import.meta.env.DEV && error && error instanceof Error) {
    details = error.message;
    stack = error.stack;
  }

  return (
    <main style={{ margin: "0 auto", maxWidth: 960, padding: "4rem 1rem" }}>
      <h1>{message}</h1>
      <p>{details}</p>
      {stack && (
        <pre style={{ overflowX: "auto", padding: 16 }}>
          <code>{stack}</code>
        </pre>
      )}
    </main>
  );
}

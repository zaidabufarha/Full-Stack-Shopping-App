import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { MantineProvider } from '@mantine/core'
import { RouterProvider } from 'react-router-dom'
import '@mantine/core/styles.css'
import './index.css'
import { theme } from './theme.ts'
import { router } from './app/router.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <MantineProvider theme={theme} defaultColorScheme="light" forceColorScheme="light">
      <RouterProvider router={router} />
    </MantineProvider>
  </StrictMode>,
)

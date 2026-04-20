export type Theme = 'dark' | 'light'

export const useTheme = () => {
  const theme = useState<Theme>('theme', () => 'dark')

  const setTheme = (t: Theme) => {
    theme.value = t
    if (import.meta.client) {
      document.documentElement.dataset.theme = t
      localStorage.setItem('ml-theme', t)
    }
  }

  const toggleTheme = () => setTheme(theme.value === 'dark' ? 'light' : 'dark')

  const initTheme = () => {
    if (!import.meta.client) return
    const saved = localStorage.getItem('ml-theme') as Theme | null
    const sys = window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark'
    setTheme(saved ?? sys)
  }

  return { theme, setTheme, toggleTheme, initTheme }
}

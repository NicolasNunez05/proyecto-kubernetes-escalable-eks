/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Dark Background Palette
        background: '#0f172a', // Slate 900 - Base oscuro
        surface: '#1e293b',    // Slate 800 - Cards
        'surface-hover': '#334155', // Slate 700 - Hover state
        
        // Purple Neon Palette (Primary)
        primary: {
          50: '#faf5ff',
          100: '#f3e8ff',
          200: '#e9d5ff',
          300: '#d8b4fe',
          400: '#c084fc',
          500: '#a855f7',
          600: '#9333ea',
          700: '#7e22ce',
          800: '#6b21a8',
          900: '#581c87',
          DEFAULT: '#7B2CBF', // Violeta principal
        },
        secondary: {
          DEFAULT: '#C77DFF', // Lila brillante
          light: '#E0AAFF',
        },
        
        // Text Colors
        'text-primary': '#f1f5f9',   // Slate 100 - Texto principal
        'text-secondary': '#94a3b8', // Slate 400 - Texto secundario
        'text-muted': '#64748b',     // Slate 500 - Texto terciario
        
        // Accent Colors
        accent: {
          purple: '#9D4EDD',
          cyan: '#06B6D4',
          green: '#10B981',
          red: '#EF4444',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      boxShadow: {
        'neon': '0 0 20px rgba(123, 44, 191, 0.5)',
        'neon-sm': '0 0 10px rgba(123, 44, 191, 0.3)',
        'neon-lg': '0 0 30px rgba(123, 44, 191, 0.6)',
      },
      animation: {
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'glow': 'glow 2s ease-in-out infinite alternate',
      },
      keyframes: {
        glow: {
          '0%': { boxShadow: '0 0 5px rgba(123, 44, 191, 0.2)' },
          '100%': { boxShadow: '0 0 20px rgba(123, 44, 191, 0.5)' },
        },
      },
    },
  },
  plugins: [],
}

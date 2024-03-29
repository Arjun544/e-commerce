const colors = require("tailwindcss/colors");
const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  purge: ["./src/**/*.{js,jsx,ts,tsx}", "./public/index.html"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    fill: (theme) => ({
      grey: theme("colors.gray.400"),
      lightRed: theme("colors.red.400"),
      red: theme("colors.red.600"),
      green: theme("colors.green.700"),
      lightGreen: theme("colors.green.500"),
      blue: theme("colors.blue.500"),
      yellow: theme("colors.yellow.500"),
      white: theme("colors.white"),
    }),
    colors: {
      blue: {
        light: "#D7E6FE",
      },
      darkBlue: {
        light: "#0F3460",
      },
      Grey: {
        dark: "#7176AC9F",
      },
      bgColor: {
        light: "#F9F9F9",
      },
      customYellow: {
        light: "#EC981A",
      },
      black: colors.black,
      green: colors.green,
      white: colors.white,
      gray: colors.trueGray,
      indigo: colors.indigo,
      red: colors.rose,
      yellow: colors.amber,
    },

    extend: {
      transitionProperty: {
        width: "width",
      },
      fontFamily: {
        sans: ["Roboto", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  variants: {
    extend: {
      fill: ["hover", "focus"],
    },
    width: ["responsive", "hover", "focus"],
    height: ["responsive", "hover", "focus"],
  },
  plugins: [
    require("daisyui"),
    require("tailwind-scrollbar"),
    function ({ addUtilities }) {
      const extendLineThrough = {
        ".line-through": {
          textDecoration: "line-through",
          "text-decoration-color": "gray",
          "text-decoration-thickness": "1px",
        },
      };
      addUtilities(extendLineThrough);
    },
  ],
  daisyui: {
    styled: false,
  },
};

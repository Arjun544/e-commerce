const colors = require("tailwindcss/colors");

module.exports = {
  purge: ["./src/**/*.{js,jsx,ts,tsx}", "./public/index.html"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      grey: {
        light: "#7176AC",
      },
      darkBlue: {
        light: "#0F3460",
      },
      lightGrey: {
        light: "#7176AC9F",
      },
      bgColor: {
        light: "#FAFBFD",
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

    extend: {},
  },
  variants: {
    extend: {},
    width: ["responsive", "hover", "focus"],
    height: ["responsive", "hover", "focus"],
  },
  plugins: [
    require("daisyui"),
    // require("tailwind-scrollbar"),
    function ({ addUtilities }) {
      const extendLineThrough = {
        ".line-through": {
          textDecoration: "line-through",
          "text-decoration-color": "black",
          "text-decoration-thickness": "3px",
        },
      };
      addUtilities(extendLineThrough);
    },
  ],
  daisyui: {
    styled: true,
  },
};

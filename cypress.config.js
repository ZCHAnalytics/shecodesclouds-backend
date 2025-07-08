const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    // baseUrl and apiUrl can still be injected via GitHub Actions
    specPattern: 'cypress/e2e/**/*.cy.js',
    supportFile: false,
  }
});

const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    //baseUrl and apiUrl to be injected via GH Action
    specPatten: 'cypress/e2e/**/*.cy.js'
  }
});

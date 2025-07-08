const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'https://zchresume.azureedge.net',
    supportFile: false,  // important to avoid the support file error
    env: {
      apiUrl: 'https://zchresume-api.azurewebsites.net/api/visitorcounter',
    },
    specPattern: 'cypress/e2e/**/*.cy.js',  
  },
});

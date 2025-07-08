describe('Cloud Resume E2E', () => {
  it('serves the static resume', () => {
    cy.visit('/')                       // uses baseUrl
    cy.contains('Zulfia').should('be.visible')
  })

  it('gets the visitor count from API', () => {
    cy.request({
      method: 'GET',
      url: Cypress.env('apiUrl')
    }).then((resp) => {
      expect(resp.status).to.equal(200)
      expect(resp.body).to.have.property('count').and.be.a('number')
    })
  })

  it('increments the visitor count', () => {
    let beforeCount

    cy.request(Cypress.env('apiUrl'))
      .its('body.count')
      .then((c) => {
        beforeCount = c
        // POST to increment
        cy.request('POST', Cypress.env('apiUrl'))
          .its('body.count')
          .should('equal', beforeCount + 1)
      })
  })
})
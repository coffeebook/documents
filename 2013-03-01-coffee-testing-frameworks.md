# Question

I'm writing tests for an Express.js app and I don't know how to choose between unit tests and integration tests. Currently I experimented with:

* Unit tests - using Sinon for stubs/mocks/spies and Injects for dependency injection to modules, with this approach I have to stub MongoDB and other external methods. I thought about unit testing the individual routes and then using an integration test to verify that the correct routes are actually invoked.

* Integration tests - using Supertest and Superagent, much less code to write (no need to mock/stub anything) but a test environment should exist (databases, etc..)

I'm using Mocha to run both styles of tests. How should I choose between those two different approaches ?

## Answer

You should probably do both. Unit test each non-helper method that does non-trivial work. Run the whole thing through a few integration tests. If you find yourself having to do tons and tons and tons of mocks and stubs, it's probably a sign to refactor.

[Source](http://stackoverflow.com/questions/14465245/unit-testing-vs-integration-testing-of-an-express-js-app)
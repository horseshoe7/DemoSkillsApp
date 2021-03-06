#  DemoSkillsApp

This project is basically a small app that is to demonstrate how I would set up a project on iOS.  It favours the MVVM design pattern; the natural successor to the MVC design paradigm that Apple still writes its sample projects with.

In addition, it shows how a simple backend API client could work.

The idea is that it simulates a TV-watching app.  The focus is really not on what the user sees here, but this project exists to show a few things:

- How one could fetch some data from a RESTful web service, parse the result into models. 
- Show the MVVM pattern in practice.
- Show a bit about how I organize my code projects, including some typical pipelines (like using SwiftGen), how you can use run scripts to improve your build pipeline, and how I approach the topic of logging.
- How you can mock your server communication so that you reduce your dependence on the server, and both sides can just implement the API contract.

Suggestions for future work:
- integrate with an actual backend.  For now, using Cocoapods and OHHTTPStubs to 'simulate' a server.
- Show off a GraphQL solution
- Break the project out into dependent frameworks depending on purpose  (i.e. networking, system, etc.)

## Contact

Written by Stephen O'Connor.  Email:  oconnor.freelance@gmail.com



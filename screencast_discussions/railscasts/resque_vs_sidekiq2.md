# Resque vs Sidekiq

At Carbon Five, I've been working on a project that involves using Resque to queue upm background jobs for tasks we don't want baked into the app (emailing users, etc).
Lately, our team noticed that Resque may not be the best solution for this, so we did a brief spike on Sidekiq vs. Resque. Here's the result of that spike:

## Where the Song Remains the Same
* Server: Both Resque and Sidekiq require the use the of Redis. Their background jobs are persisted via JSON serialization.
* Web Monitoring: The two services each provide a web interface (Sinatra) for debugging and monitoring jobs. Their setups are almost identical, and it not difficult at all to hide them behind an authentication wall.

## Differences
...wip...

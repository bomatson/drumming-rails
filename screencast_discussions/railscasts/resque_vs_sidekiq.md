# Resque

## Example
Ryan starts by displaying his snippet Rails app that makes a POST request to an external service to do syntax highlighting
This is not performant, because relying external requests could tie up entire Rails process if its slow.
We want to setup reqsue to handle the background job

## Implementation
Resque requires running a redis server via `brew install redis`. Then in your Gemfile, include `gem 'resque'`
Next, include a file called 'resque.rake' in the lib/tasks directory. Within that file:

```
require "resque/tasks"

task "resque:setup" => :environment
```

From the CLI, run: `rake resque:work QUEUE="*" `

"*" will run all the Resque tasks

Within  the controller, where we create the snippet, we would include the Resque enqueue function passing in the worker Class.
We also need to pass in additional arguments and pass in our snippet model. Resque gets converted into JSON because its stored in a Redis db,
so we will only want to pass in a simple object, like the snippet id:

```
if @snippet.save
  Resque.enqueue(SnippetHighlighter, @snippet.id)
```

Not sure if this is still kosher for modern Rails, but the next step for Ryan is creating a worker file under app/workers/snippet_highlighter.rb:

```
class SnippetHighlighter
  @queue = :snippets_queue

  def self.perform(snippet_id)
    snippet = Snippet.find(snippet_id)
    ... code that does the syntax highlighting using the snippet object ...
  end
end
```

Unfortunately, the syntax highlighting job is failing.

## Debugging
Resque runs a sinatra app in the background to monitor the resque jobs. To start, call `resque web`
It could not load the class because we did not restart the rake task (it had not loaded the SyntaxHighlighter class)
Code snippets are now working with syntax highlighting!

## Embed Resque in Rails
In the routes file, include `mount Resque::Server, at: "/resque" `
From there, it is recommended to have some authentication around this web interface (whether its devise or basic http)

## Benefits
* Resque is really well-tested and supported.
* Resque has a really clean interface for debugging jobs

## Cons
* Resque does polling on the queue, which means there might be delay between when a job is added to an empty queue and when it can be processed

# Sidekiq

## Implementation
Using the same example as above running on Redis, Ryan creates a worker directory within the Rails app and provides a `PygmentsWorker` class:

```
class PygmentsWorker
  include Sidekiq::Worker

  def perform(snippet_id)
    snippet  = Snippet.find(snippet_id)
    ... code that does syntax highlighting using the snippet object ...
  end
end
```

Within your SnippetsController, you should include:

```
if @snippet.save
  PygmentWorker.perform_async(@snippet.id)
```
From the CLI, you can boot up the Sidekiq queue by running `sidekiq`

Keep in mind, it will auto retry if there is an error. If an exception is raised, take a look at side effects. To disable, include `sidekiq_options retry: false`

Also,  you'll need be threadsafe for code you use with the worker. Avoid sharing data which is muttable between instances. 

One more thing, you'll probably want to increase your pool size on development and prod (see database.yml)

## Cool Features
It is simple top schedule workers for time other than now:

```
if @snippet.save
  PygmentWorker.perform_in(1.hour, @snippet.id)
```

You can also prioritize queues, by setting `sidekiq_options queue: 'high'` in the PygmentWorker class
Then, from the CLI run `sidekiq -q high, 5 default` and the high queue will take priority
Re: monitoring, the setup is the same as Rescue, where you add this to your routes file:

```
require 'sidekiq/web'

...
mount Sidekiq::Web, at: '/sidekiq'
```

Also, you need to add sinatra and slim to your Gemfile in order to access the web interface

## Benefits
* Sidekiq handles multiple jobs concurrently using threads instead of processes, which can save on memory.
* Easy to understand ExceptionHandling for retries
* Includes Celluloid for concurrency in Ruby

## Cons
* You need to ensure your code is threadsafe, and multithreading can open a whole can of worms.

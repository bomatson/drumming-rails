# Nil in all its evil

## Setup
Gary starts by creating a Person class with a name attribute and the ability to find a peron by id.
Next, he creates a SubscriptionController with a create method to associate a Person with a subscription (by id)
A Subscription model allows him to create a subscription from a person id (create_for_person) and a stubbed create! method
He then calls SubscriptionController.new.create(id)i, which successfuly calls Subscription.create! for existing ids

## The problem
When he calls an id that does not exist, he gets an error "undefined method 'name' for nil:NilClass"
The line that introduces the nil is not in stacktrace
Introduction of the nil is not local to the use of the nil in the traceback

## A solution
He solves this by using:
```ruby
  people.fetch(id)
```
Instead of
```ruby
  people[id]
```
Rails gets this right when finding by id, but not when finding by slug (or other dynamic finder) unless using !

## Other ways to avoid the nil
- Depending on your domain model, it may be better to switch where you define the model relationship

example: put attr_reader :person on Subscribe model rather than other way around.

- Instead of using attr_reader, you can roll you're own:
```ruby
class Person
  #attr_reader

  def subscribe!
    @subscription = Subscription.new
  end

  def subscription
    @subscription or raise NoSubscriptionError
  end
end

class NoSubscriptionError < Exception
end
```

Localizing is not ideal, since we mainly just don't want it to fail
- Return a new type of person (Subscriber) as a separate class that gets a subscription instead of mutating Person with subscription
  - Please see example.rb for this example

## Sum it up

To avoid the terrible pains of nil:

- Use libraries and language intelligently
- Invert the object relationship
- Guard against nils in a manual attribute reader
- Introduce new domain concepts

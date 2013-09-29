#Exceptions and Control Flow

## Setup

Gary sets up a function that finds a file and returns the content within the file as a string.
If we try to do it on a file that does not exist, it raises `IOError`.
He then uses logic (`if`/`else`) and `os.path` to return the contents only if the file exists.

## Problem
My function now assumes that file has the capacity to be opened, which is not true.
Now we need to tie ourselves to three libraries and more logic in order to make this work:

```python
if os.path.exists(path) and is_readable(path, current_user()):
  return open(path).read()
```
## Recommendation
Testing becomes a nightmare in this case. His recommendation is to just try it and raise an IOError:

```python
try
  return open(path).read()
except IOEError
  return ''
```

(Python's try is equivalent to a `begin | rescue | ensure` block in Ruby.)

## Another Issue
He then moves on to search for files in a hash of filenames, and only return the path if the file exists:

```python
if dotfile_name in filenames:
  path = filenames[dotfile_name]
else:
  path = '/Users/grb/.%s' % dotfile_name
```

This presents a similar type of error, as we end up relying on Python's magic `__contains__` method.
At least the assumption is safe, since we can only read files that are open.

However, the structure is a bit funny. The first thing in the function is a check for the 'special' case.
The 'special' case is **around** the 'general' case.

## Another solution

Use the happy case (the general case) without invoking any logic and then use the special case on `KeyError`:

```python
try:
  path = filenames[dotfile_name]
except KeyError:
  path = '/Users/grb/.%s' % dotfile_name
```

Think of it as a mechanism for mapping errors in dependencies onto normal cases for the code.
Mapping failures onto normal behavior is tricky, and we want to avoid it.

## Caveat

Exception handling should not always be a part of control flow, but it should always be a part of active toolset.
If I was calling a specific function that was complex, this would not be a good design pattern.
In the try block, I only want one function to be called.

## Summary
Using exceptions as part of control flow:
* Reduces the number of calls you need.
* Reduces behaviors of multiple method calls.
* Right order, general case first and special case next.
* Calls out failure in dependency to an expected case in your code.

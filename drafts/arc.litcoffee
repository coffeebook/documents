

Back when I first started playing with node.js, there was one thing that always
made me uncomfortable. Embarrassingly, I'm talking about module.exports. I say
embarrassingly because it's such a fundamental part of node.js and it's quite
simple. In fact, looking back, I have no idea what my hang up was...I just
remember being fuzzy on it. Assuming I'm not the only one who's had to take a
second, and third, look at it before it finally started sinking in, I thought I
could do a little write up.

In Node, things are only visible to other things in the same file. By things, I
mean variables, functions, classes and class members. So, given a file misc.js
with the following contents:

```javascript
var x = 5;
var addX = function(value) {
  return value + x;
};
```

Another file cannot access the x variable or addX function. This has nothing to
do with the use of the var keyword. Rather, the fundamental Node building block
is called a module which maps directly to a file. So we could say that the above
file corresponds to a module named file1 and everything within that module (or
any module) is private.

Now, before we look at how to expose things out of a module, let's look at
loading a module. This is where require comes in. require is used to load a
module, which is why its return value is typically assigned to a variable:

```javascript
var misc = require('./misc');
```

Of course, as long as our module doesn't expose anything, the above isn't very
useful. To expose things we use module.exports and export everything we want:

```javascript
(file1)
var x = 5;
var addX = function(value) {
  return value + x;
};

module.exports.x = x;
module.exports.addX = addX;
```

Now we can use our loaded module:

```javascript
(file2)
var misc = require('./misc');
console.log("Adding %d to 10 gives us %d", misc.x, misc.addX(10));
```

```coffeescript


    class Outline

        constructor = (@id, @filename, @metadata) ->
            console.log "Created a new outline"





```


```coffeescript

    # path/to/file/file01
    x = "";

```

This is a file and thus a module.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
montes, nascetur ridiculus mus. Using the name of the means choosing it wisely,
variable __winston__ means we need to do a __= require 'winston'__. Felis,
ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis
enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In
enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis
eu pede mollis pretium.

Aenean //commodo()// ligula eget //dolor()//. This would be a new line. Aenean
massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur
ridiculus mus.

```coffeescript

    commodo = -> console.log "commodo"
    dolor = -> return "dolor"

```


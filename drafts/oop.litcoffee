For developers trained classically in OOP [Java, C++, Delphi, and AS3],
Javascript can be very challenging. Expertise in Javascript requires developers
to understand prototypal inheritance, closures, partial applications, currying,
and more.

Combine these learning requirements with an understanding of function
constructors and… well, OOP developers can quickly become discouraged.

Developers migrating to Javascript may even be tempted to discard all the best-
practices learned during their OOP efforts.

This article is intended to demonstrate to developers that CoffeeScript and
Javascript can both be used to implement object-oriented code with structures
used in the `classic` languages. The samples here will use Javascript and
CoffeeScript. But I think developers will quickly find CoffeeScript to be the
DSL of choice.

Class and Inheritance

With Coffeescript it is really easy to create a Class with inheritance,
constructors, and even use super() to invoke parent method overrides.

Shown below are two (2) class definitions: Animal and Dog.

    class Animal
        constructor : (@species, @isMammal=false) ->

    class Dog extends Animal
        constructor : (@name) ->
            super ("canine",true)

        toString : ->
            "#{@name} is a #{@species}."


This code is very clean and easily understood. And it starts to give us that
object-oriented feel…

For the sake of completeness, let’s see what happens when we transcompile the
coffeescript into javascript. The generated javascript code becomes much less
palatable:

```javascript

(function() {
var Animal, Dog,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

Animal = (function() {

  function Animal(species, isMammal) {
    this.species = species;
    this.isMammal = isMammal != null ? isMammal : false;
    return this;
  }

  return Animal;
  })();

  Dog = (function(_super) {

    __extends(Dog, _super);

function Dog(name) {
  this.name = name;
  Dog.__super__.constructor.call(this, "canine", true);
  return;
}

Dog.prototype.toString = function() {
  return "" + this.name + " is a " + this.species + ".";
};

return Dog;

  })(Animal);

}).call(this);

Notice how the Coffeescript `class Animal` transcompiles to generated Javascript:

var Animal = (function() {

    return function(){
        // Constructor function
    }

})();

I think this simple example demonstrates why OOP solutions are less common in standard javascript. Most javascripters do NOT use classic inheritance approaches because of these complexities. It is simply easier to hand-write javascript with Functions, closures, and prototypal patterns such as the Module pattern.
jQuery, Sencha ExtJS, and AngularJS are great examples of non-OOP Javascript that use amazing functional implementations of JavaScript. Those libraries are terse, amazingly complex, elegant libraries that ALL developers should study. These do not use the OOP inheritance mechanism illustrated above. Instead, they use a prototypal extend() mechanism.

Sencha’s ExtJS framework provides a robust Ext.define() that encapsulates many
features into a single function: loads the required classes [if not already
loaded], constructs the instance, inject prototypes and mixins, and more…

// This defines a class Developer thatextends User, so User.js will be loaded first

Ext.define('Developer', {
  extend: 'User',

 // Aspect support to inject features into instances
 mixins: {
  magicSkills: 'HackerSkills'
 },

 //SuperUsers are always super...
 constructor: function() {
  this.setIsSuper(true);
 }
});

// This instantiates an instance of Developer after it has been defined.

Ext.require('Developer', function() {
  var dev = new Developer();
  dev.setEmail('tommy@sencha.com');
  dev.hackAway();
});

Further exploration of prototypal instantiations is out-of-scope for this article.

Nevertheless, object-oriented javascript techniques should not be ignored and
can be used to build robust custom libraries and frameworks. The above example
also highlights why CoffeeScript has such impressive syntactical sweetness. Once
tasted, the sugar rushes derived from OO Coffeescript cannot be ignored.
CoffeeScript changes the reality and exposes new opportunities.

But all is not perfect in the candy land of CoffeeScript… at least not yet!

To truly feel comfortable with implementing OO javascript architectures and libraries (using CoffeeScript), we need to employ more of the classic OOP constructs. Constructs such as:

  Packages
  Imports
  Public Methods & Properties
  Private Methods & Properties
  Static Methods & Properties

So let’s explore these constructs with Coffeescript implementations and see how you can have the best of both worlds: full-featured, object-oriented Javascript using CoffeeScript.


Packages

Using the Animal and Dog classes defined earlier, we notice that packages were not used.

Both classes (Function constructors) are hoisted to the root closure or global variable space. As part of our exploration of OO Javscript, we want to change these class definitions to use packages structures such as:

    samples.coffeescript.oop.abstract.Animal
    samples.coffeescript.oop.pets.Dog

How would we do this in Javascript?

First, we would need to build an object tree for all the packages. Then we assign class references to end-nodes in our object tree:


var samples = {
       coffeescript : {
         oop : {
              abstract : { Animal : null },
              pets     : { Dog    : null }
         }
       }
    };

samples.coffeescript.oop.abstract.Animal = Animal;
samples.coffeescript.oop.pets.Dog        = Dog;

(exports || window) = samples;

I am sure everyone will agree that effort required for this manually
specification is not comforting. And it becomes increasingly painful as the
quantity of classes and packages accumulate.

Of course, we could create a `package builder` utility function to solve this for us.

(function() {

var namespace = (function(package,values) {
  var results = [ ],
    target  = exports || window,
    folders = name.split('.');

  each (folders , function(subpackage) {
    target = target[subpackage] || (target[subpackage] = {});
  });

  for (key in values) {
    results.push( target[key] = values[key] );
  }

  return results;
};

namespace( "", { namespace : namespace } );

})(this);

Note: the JavaScript utility shown above is not JSLint compliant nor intended to
be a example of great JS code; it has been simplified for easy understanding.


Fortunately, John Yanarella @ CodeCatalyst has already created the open-sourced
namespace.coffee to solve the package issue for us in Coffeescript; …a very
elegant solution indeed:

    namespace "samples.coffeescript.oop.abstract"
        Animal :
            class Animal
                constructor : (@species, @isMammal=false) ->
                    return this

    # NOTE: Animal must be defined BEFORE Dog
    #
    namespace "samples.coffeescript.oop.pets"
        Dog :
            class Dog extends samples.coffeescript.oop.abstract.Animal
                constructor : (@name) ->
                    super( "canine", true )
                    return

                toString : ->
                    "#{@name} is a #{@species}."

Using the global namespace() function makes it trivial to organize your classes
into packages structured by context, categories or any other criteria. Developer
caution recommended.

Developers are encouraged to exercise caution in defining the endpoint package
key. Below we have the class name Animal as defined by class Animal and we have
the package key Animal as defined by Animal :. 1 2 3 4 5

namespace "samples"
    Animal :
        class Animal

# supports  `new samples.Animal()`

If the package key does not match, then the construction will not work as expected.

Below we changed the package key from Animal to Group.
1
2
3
4
5
6

namespace "samples"
   Group :
       class Animal

# `new samples.Animal()` will thrown an undefined exception
# `new samples.Group()` must now be used because of the key name `Group`.

As such, I highly recommend that developers use the same package key name as the class name.


Imports

Unlike compiled languages where source code is converted to bytecode or opcodes, Javascript raw source code must be loaded [using browser HTML <script />, eval(), or the Node.js require()] into the javascript runtime engine before use. And when using package notation, the full package must always be specified in order to reference a particular class.

Or maybe not…

Developers can use an alias technique to store a private, short reference to the public full package reference.

Consider the PetMaker class below which will create instances of Dogs on demand.
1
2
3
4
5
6
7
8

namespace "samples.coffeescript.oop"
    PetMaker :
        class PetMaker
            constructor : ->

        createDog : (name) ->
            clazz = samples.coffeescript.oop.pets.Dog
            return new clazz(name)

Above, we created a local variable clazz as an alias that is assigned a reference to the full package Dog class.

If, however, we are referencing many external package classes, this approach can get messy. So let’s refine the technique:
1
2
3
4
5
6
7
8
9
10
11
12
13
14

namespace "samples.coffeescript.oop"
    PetMaker :
        class PetMaker
            constructor : ->

            createDog : (name) -> new Dog(name)
            createCat : (name) -> new Cat(name)
            createBird: (name) -> new Bird(name)

      # private variable declarations
      #
      Dog = samples.coffeescript.oop.pets.Dog
      Cat = samples.coffeescript.oop.pets.Cat
      Bird= samples.coffeescript.oop.pets.Bird

Here we created private variable references to the constructors of the packaged Dog, Cat, and Bird classes.

More importantly, what we have effectively done is imported the required classes. This technique become very valuable when you want to import enumerator classes, constants classes, utility classes, etc.
Note: this import technique still requires the developer to load the Javascript libraries in the correct order; otherwise runtime reference errors will occur. Developers are encouraged to use loaders like Head.js or Require.js.


Public Methods & Properties

In Javascript, we can use generic objects to expose public methods with access to private closure variables, states, and functionality.
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43

(function(){

      var person = (function Person() {

            /**
             * private closure variables with state
             */
            var fullName = "Thomas Burleson",
                url      = "www.gridlinked.info";


            /**
             * Define private method that can be invoked
             * as either a getter or a setter
             */
            var domain  = function(site) {
                if ( site ) {
                    url = site;  // mutator feature
                } else {
                    return url;  // accessor feature
                }
            }

            /**
             * Publish an object with specific public APIs
             */
            return {
                name     : function() { return fullName; },
                website  : domain
            }
      }());

      // person.fullName                    == undefined
      // person.domain                      == undefined
      // person.url                         == undefined

      // typeof( person.website )           == "function"

      // person.website()                   == "www.gridlinked.info"
      // person.website("www.babelfx.org")
      // person.website()                   == "www.babelfx.org"

})();


We can also use prototypes with Function constructors to expose public methods and state.
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57

(function(){

      var Person = (function() {

            /**
             * Constructor function
             */
            function Person( first, last, nick ) {
                /**
                 * private variables with state
                 */
                var firstName = first || "Thomas",
                    lastName  = last  || "Burleson",
                    website   = "www.gridlinked.info";

                /**
                 *  Public instance properties with state
                 */
                this.nickname    = nick || "ThomasB";

                /**
                 *  Privileged instance methods
                 */
                this.userName = function() {
                    return firstName + " " + lastName;
                };
                this.website = function(site) {
                    // Accessor or mutator function
                    if ( site ) { website = site;  }
                    else        { return website;  }
                };

                return this;
            }

            // Public prototype methods
            Person.prototype.toJSON = function() {
                return {
                    url : this.website(),
                    name: this.userName()
                };
            }

            return Person;
      })();

      // Person.nickname == undefined

      var person = new Person('Thomas', 'Burleson');

      // person.firstName  == undefined;
      // person.nickname   == "ThomasB";
      // person.userName() == "Thomas Burleson";
      // person.website()  == "www.gridlinked.info";
      // typeof ( person.toJSON() ) == "object";

})();

The definition above creates public methods inside the the constructor function. This is required so such public methods have closure access to private/local variables.

We can also use Person.prototype to define public methods for any instance of Person. Prototypes are powerful live constructs; any runtime changes to Prototypes will be applied to all current and new instances of Person.

Now that we have seen the direct Javascript technique, how would we realize similar public methods/properties in Coffeescript ?
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19

class Person
    # Constructor function
    constructor : ( @first = "Thomas", @last="Burleson", @url="www.gridlinked.info" ) ->

        # public instance method
        #
        @userName = -> "#{@first} #{@last}"

    #
    # Public prototype methods
    #
    website  : (site) ->
        if site? then (@url = site) else @url

    toJSON : ->
        return {
            url : @website()
            name: @userName()
        }

Wow! The CoffeeScript code is significantly more terse and concise.

And we should study the class definition which also demonstrates some important aspects and techniques.

    Constructor arguments can be assigned defaults
    The constructor argument @url is simultaneously used to initialize a public instance property url.
    The constructor arguments first and last capture closure state for the userName() accessor function.
    Public method userName() is defined for each instance. Constructor definitions like these are the ONLY approach available if public methods require access to function arguments or closure state.
    Public method toJSON() and website() are a prototype functions. These functions are defined only after a new Person() instantiation. Any changes to these prototypes function will apply to ALL current and future instances.


Private Properties and Methods

What about private class properties and private methods?
I highly recommend the readers study the articles Understanding Javascript OOP, Private data for objects in JavaScript and Crockford’s Private members in Javascript. Those are best read before readers study the coffeescript versions below.

And yes, private properties and method constructs are also possible within Coffeescript classes.
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20

class Person
    constructor : ( @first = "Thomas", @last="Burleson", nick="ThomasB" ) ->
        # Private variable
        url = ""

        # Private method must properly set `this` scope;
        # so we use syntax `=>`
        #
        getFullName = => "#{@first} #{@last}"

        # Privileged methods
        @userName = -> getFullName()
        @website  = (site) ->
            if site? then (url = site) else url

    toJSON : ->
        return {
            url : @website()
            name: @userName()
        }

This is the almost the same Person class shown before WITH some important, subtle differences. The code has been modified to demonstrate the use of private properties and methods.

    Local variable url = defines a private property (since it is accessed vai the website() getter/setter method). Such properties can be accessed via closures ONLY by public methods defined within the constructor.
    Local variables can be defined as private functions. Notice the use of getFullName = -> to define a local variable as a private method.
    Privileged methods @userName() and @website() are defined for each instance. Construction definitions like these are the ONLY approach available if public methods require access to instance-level private properties or functions.
    Notice the use of getFullName = => to define a private method that still has access to instance-level public properties such as @first aka this.first.
    The @website method is no longer defined as a prototype method. It is a privileged method since it needs access to the private property url.

Normally, I do not worry about constructing private attributes EXCEPT when I absolutely do not want to allow any external access to that functionality or state.

As an architect, encapsulation and coupling are extremely important.

I hope this code demonstrates that private methods and properties are easily constructed… just not as easily as public methods and properties.


Static Properties and Methods

And finally, `static` methods and properties are also possible.

Similar to the classical OO languages, static javascript constructs are global for the Class and are [usually] partitioned separate of- and have different scope with respect to instances or prototypes.

Typical usages of statics are for constants, enumerations, utility methods, etc.

Here is a simple example of static features in Javascript:
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15

var Health = function () {  };

Health.UNKNOWN  = 0;
Health.CRITICAL = 1;
Health.SEVERE   = 2;
Health.WARNING  = 4;
HealhtStatus.OK       = 8;

Health.groupHealth = function(group) {
  // determine status of group of people

  return !group         ?
         Health.UNKNOWN :
         _.max(group,  function(it){ return it.health; })
}

The equivalent in CoffeeScript is:
1
2
3
4
5

class Health
    [ @UNKNOWN, @CRITICAL, @SEVERE, @WARNING, @OK ] = [ 0,1,2,4,8 ]

    @groupHealth : (group) ->
        if (group) then _.max( group, (it)->it.health ) else @UNKNOWN

We could even define private methods that could be used from public static methods. Consider
1
2
3
4
5
6
7
8
9
10
11
12

class Health
    [ @UNKNOWN, @CRITICAL, @SEVERE, @WARNING, @OK ] = [ 0,1,2,4,8 ]

    @groupHealth : (group) ->
        if (group) then _.max( group, (it)->it.health ) else @UNKNOWN

    @allInjured : (group) ->
        if (group) then _.filter(group, isInjured ) else [ ]

    # Private method
    isInjured = (person) ->
        (person.health & (@CRITICAL | @SEVERE))

I should also point out that private methods can even be used as if they were prototype methods. In order words, private methods can use the this scope if invoked properly.
1
2
3
4
5
6
7
8
9

class Health
    [ @UNKNOWN, @CRITICAL, @SEVERE, @WARNING, @OK ] = [ 0,1,2,4,8 ]

    @isEmergency : (person) ->
        hasPain.call(person)

    # Private method for bitflag tests
    hasPain = () ->
        (this.health & (@CRITICAL | @SEVERE))

Here we used the hasPain.call( person ) method to invoke the function within scope of the person instance.

Developers often find the need to use .call(), .apply(), and .bind() to set scope context within their functions. If you don’t need them currently, just remember this article as hint to their usages… for your future needs.

Resources

Here links to additional, recommended study resources:

    Understanding Javascript OOP,
    Private Data for Objects in JavaScript
    Private Members in Javascript

Summary

Hopeful this article has provided an understanding on packages, public & private properties, and static features. I also hope that I have fostered a serious appreciation for CoffeeScript and the tremendous power it offers developers.



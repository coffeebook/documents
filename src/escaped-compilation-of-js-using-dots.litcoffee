# LCS + GFM Test page 01

This is a test page with stub data and executable code that works in both
Literate CoffeeScript (LCS) (it compiles to JavaScript) and GitHub Flavored
Markdown (GFM) (it displays nicely on GitHub and possible later, other web sites
running versions of it.

```
Objectives:         demonstrate basic use, get name of this file
Mocking:            stub paragraphs
Environment:        isomorphic (browser/console)
Result:             ✓ passed
```

    myself = __filename

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque
eu, pretium quis, sem. Nulla consequat massa quis enim.

__NOTE__ These fences are not visible if you view this document inside a GFM
viewer, like used on GitHub (README's, issue pages - it has more features).

```coffeescript

    # executable code
    console.log myself

```

I was looking for a nice way to still mix-up other code with executable
CoffeeScript so the max result could be gained.

I decided for `.` dots on the first column of the new line.

```javascript

.    function myFunction()
.    {
.        document.getElementById("myPar").innerHTML="Hello Dolly";
.        document.getElementById("myDiv").innerHTML="How are you?";
.    }

```

It beats the alternative of staying below 4 spaces, but it's doable for some
code snippets like the previous:

```javascript

function myFunction()
{
  document.getElementById("myPar").innerHTML="Hello Dolly";
  document.getElementById("myDiv").innerHTML="How are you?";
}

```

Pitfall 1: Variables are function-scoped. Barely manages 1 space indention.

```javascript
var myvar = "global";
function f() {
 print(myvar); // (*)
  if (true) {
   var myvar = "local"; // (**)
  }
 print(myvar);
}
```





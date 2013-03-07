
# Concept tangle functions

## Prequisites

The following is needed:
* Node.js
* some other stuff I will mention

## History

The history of stuff...

## Essential information

### Migrating from JavaScript

Here are some of the "gotchas" I've encountered when I converted all the
javascript code into coffeescript.

*Disclaimer: Coffeescript is a great productivity booster for me personally.
Even with all the things outlined below, it is still way better than javascript.
None of these should discourage you from jumping into it right away.*

#### Major gotchas
(Things that generate wrong code silently)

#### The ?: setup is translated differently without warning.
For example, these two lines:

```coffeescript
# Really need to convert lines like this
candy = good() ? 1 : 0
# to this before you rename the .js to .js.coffee
candy = if good() then 1 else 0
```

Generates code like these:

```javascript
// Unexpected!
candy = (_ref = good()) != null ? _ref : {
  1: 0
};
// Expected
candy = good() ? 1 : 0;
```

#### The implicit return values

CoffeeScript __always returns the last *expression*__ (like in ruby). This can
be fairly unexpected for javascript programmers, and easily overlooked (even
with people fluent in ruby). I end up almost always terminate a void function
with empty `return` statement. For example:
<https://gist.github.com/liaody/1598046/raw/104021b4a2bc1a8bc65b758414a4ac304b878cfb/coffeescript_gotcha.md>

```coffeescript
with_return = ->
  doStuff()
  return

without_return = ->
  doStuff()
```

get translated to this:

```javascript
with_return = function() {
  doStuff();
};

without_return = function() {
  return doStuff();
};
```

Returning the last value may not seem like a big deal until it hits you in event
handlers (last expression evaluated to false).

#### Need to be careful with white spaces within expressions

Completely understandable, but still:

```coffeescript
# No space: Good
'Time:'+hour+' hours'
# Irregular spaces: Bad
'Time:' +hour +' hours'
# All spaced: Good again
'Time:' + hour + ' hours'
```

here is what these statements get translated to:

```javascript
'Time:' + hour + ' hours';

'Time:' + hour(+' hours');

'Time:' + hour + ' hours';
```

#### Potentially incorrect code with the range (`..`/`...`) logic in for loops

CoffeeScript range `..`/`...` works in both directioins. In case the compiler
does not know which direction to take, it generates dynamic code to do both.
This is usually not intened, and there is no good way to specify direction of
range. For example:

Original JavaScript code:

```javascript
var sum = 0;
for(var i=5;i<arr.length;i++)
{
  sum += arr[i];
}
```

Naively, I would translate it to these coffee script code:

```coffeescript
sum = 0
for i in [5..arr.length]
  sum += arr[i]
```

and be surprised to see that actual javascript generated to be this (wrong logic
for `arr.length` less than 5)

```javascript
var i, sum, _ref;

sum = 0;

for (i = 5, _ref = arr.length; 5 <= _ref ? i <= _ref : i >= _ref; 5 <= _ref ? i++ : i--) {
  sum += arr[i];
}
```

Even in the cases where logic is not wrong, it is still inefficient to do two compares for each iteration.

# Minor Gotchas
(Things that are understandable and relatively easily fixable)

## Beware when converting `var my = this;` to `=>` pattern
Sometimes `this` is used together with `my` (e.g. in event handlers this used to refer to element)

In many cases I need to convert code like this:

```javascript
var my = this;
$('.tab').click(function()
{
  my.switchTab($(this).data('tab'));
})
```

to the code below with alternate way to get to the event target.

```coffeescript
$('.tab').click (ev)=>
  @switchTab $(ev.target).data('tab')
  return
```

(Lately I would use `_.bindAll` and switch from `=>` to `->`, to avoid `=>` as much as I can)

#### Typo of `->` to `=>` is hard to notice
(Made worse by this effect: http://www.hiddentao.com/archives/2011/11/09/coffeescript-function-binding-gotcha-when-using-cloned-spine-models/)

#### Typo of `->` to `=` is hard to notice
Function `b()` disappears in below code. Would be a good candidate for a "coffeescript lint" tool.

```coffeescript
class Test
 a: ->
  doStuffA()
  return
 b= ->
  doStuffB()
  return
```

###(fixed indent to 1)

#### Block comment style

Block comment style ### sometimes mysteriously interfere with "pound lines" like
"#####################" in the original javascript code. Syntax highlighting
saves the day here. (Why mysterious? It only treat code block as comment if
number of pounds in your line satisfies (nPounds/3)%2==1)

For example

```coffeescript
#############
doStuff1()
###############
doStuff2()
#########
```

#### Foward declarations are not straightforward in some situations.

```javascript
var count;
function Show() { count += 1; ActualShow(); }

$(function()
{
  count = 0;
  Show();
  setInterval(1000, Show)
});
```

Naive translation wouldn't work. A dummy assignment is required to get the
proper forward declaration

```coffeescript
count = null
Show = ->
  count += 1
  ActualShow()

$ ->
  count = 0
  Show()
  setInterval(1000, Show)
```

#### Not immediately apparent how to do one-liner fluent jquery-style bindings (to put parenthesis right before the arrow)

```javascript
$('#el').focus(function(){ DoFocus(); }).blur(function(){ DoBlur(); })
```

Took me a while to realize that I can write like this

```coffeescript
$('#el').focus( -> DoFocus()).blur( -> DoBlur())
```

Then again, this is not quite correct due to implicty return problem mentioned
above, so I end-up have to write something like this:

```coffeescript
$('#el').focus ->
  DoFocus()
  return
.blur ->
  DoBlur()
  return
```

Much less fluent than the original javascript.

## Lack of an easy way to traverse an array in reverse order

I have to write:

```coffeescript
idx = words.length
while i > 0
  i -= 1
  words.splice(i,1) if (words[i].length < 2)
```

instead of

```coffeescript
reverse_for word, i in words
  words.splice(i,1) if (word.length < 2)
```

NOTE: I used to do something shown below, which is actually incorrect. Can you
discover the bug? Again it is related to the special behavior of coffeescript
for-loop construct.

```coffeescript
for word, i in words
  if (word.length < 2)
    words.splice(i,1)
    i-- # works, but scary
```


## Stray space causes big trouble

```coffeescript
# Good coffeescript ...
if (cc)
  a()
  b()
# turns bad if your coffee cup hits the space bar
if (cc)
   a()
  b()
```

translates to these:

```javascript
if (cc) {
  a();
  b();
}

if (cc) a();

b();
```

## Typo between `of` and `in` can be hard to detect
Could've warned me of this because I have the `own` keyword there.

```coffeescript
# I wanted to do this:
for own id of list
  doStuff(id)
# But end up doing this
for own id in list
  doStuff(id)
```

Coffeescript just blissfully generate code for both lines:

```javascript
var id, _i, _len,
  __hasProp = Object.prototype.hasOwnProperty;

for (id in list) {
  if (!__hasProp.call(list, id)) continue;
  doStuff(id);
}

for (_i = 0, _len = list.length; _i < _len; _i++) {
  id = list[_i];
  doStuff(id);
}
```


## Passing both a function and a hash can be tricky

This does not work, generates PARSE ERROR ON LINE 2: UNEXPECTED 'INDENT'

```coffeescript
FB.login
 (response) -> doStuff(); return
 scope: 'email'
```

This works:

```coffeescript
FB.login(
 (response) -> doStuff(); return
 scope: 'email')
```

## Missing a good for loop construct, like this:
```coffeescript
for(n=head; n!=null; n=n.next)
 dostuff()
```

And there is no do-while loops - See: http://stackoverflow.com/questions/6052946/were-do-while-loops-left-out-of-coffeescript

SOURCE: https://gist.github.com/liaody/1598046/raw/104021b4a2bc1a8bc65b758414a4ac304b878cfb/coffeescript_gotcha.md

MUST READ: http://ceronman.com/2012/09/17/coffeescript-less-typing-bad-readability/

We would need a few 'constants', although technically we have no such thing. A
constant is a non-varying value, meaning a value that is completely fixed or
fixed in the context of use.

The directory where we will place our `.md` files is one such thing, a constant
value, since it won't change once set. The term usually occurs in opposition to
variable (i.e. variable quantity), which is a symbol that stands for a value
that may vary. Since other things may change during run time, we probably need a
easy to recognise several and further visually aid our already hard task or
doing without brackets. I for one, applied several of the explicit punctuation
marks like `,` for key values and `{ }` for objects and `( )` for methods,
because - although not enforced - it does improve readability.

Furthermore there are other tricks one can employ such as:

But in this case, I will just use a capital cased variable name:

    DIR_OUT = "out/"
    DIR_LCS = "src/"

.   CONSTANTS are one of multiple visual aids to our disposal.
.     ......
.     ;;;:;
.     ;::;;;.
.     ' ':;;;;.
.         ':;;;;
.           ':;



Lets call this __inline ascii art__ but there is no reason we are limited to
ASCII format since most will probably have the following show properly as well:

    UTF8 = "© « ®"

Remember, these are no real constant as the value can still be changed. It does
not constitute the kind that generates an error when you try to redefine it, no.
In JavaScript, you can set a global variable or a prototype property in a
constructor to a 'constant' value, but nothing constrains the value from being
changed.

Even JavaScripts own constants can be redefined, if you have a need to make
`Infinity` equal to 3.

On a lower level, immutability means that the memory the string is stored in
will not be modified. Once you create a string `"foo"`, some memory is allocated
to store the value "foo". This memory will not be altered. If you modify the
string with, say, `substr(1)`, a new string is created and a different part of
memory is allocated which will store "oo". Now you have two strings in memory,
"foo" and "oo". Even if you're not going to use "foo" anymore, it'll stick
around until it's garbage collected.

One reason why string operations are comparatively expensive.

#### NOTE :: God I would love automatic sense lookup with wordnet...todo

    natural = require 'natural'

#### TODO :: Change " and ' etc to pretty on output

>> becomes »
>> (encapsulate)    ???

Such as inline use might be >>(if book is 'great' then 'cheer' else 'boo').

The rendered `.md` would show either » if you want to do a lot of character
replacement, or remove the >>(code).

Also, spanning text but remaining inline, we may look at [eco] which uses `:`.

Render >>(a =)<< unicode 'astral plane' >>(String.fromCharacter if CID greater
then 0xffff)<< in Google V8, CoffeeScript. Note, you will of course need to have
these as fonts on your machine installed and we _don't_ generate a warning yet
is it isn't in a terminal that can display unicode. It works great in Sublime2
with `build` option.

The top would not constitute a block, closing `<<` could be omited as we have
`>>(` as a reasonable match. This might be too heavy on rendering though.

#### FEATURE :: Above contains stub/mocked code/text mixing as an example

This will work tho...

    a = String.fromCharCode( 0xd801 )
    b = String.fromCharCode( 0xdc00 )
    c = a + b

Now to display the output

    console.log a
    console.log b
    console.log c
    console.log String.fromCharCode( 0xd835, 0xdc9c )
    # result here: \n \n 𐐀 \n 𝒜

A little verbose though...every console.log will clutter. Also I feel we should
try and prevent too much nesting (aka indents) in our executable code. In the
__literate mode__, that is unindented text starting at anywhere below `4 spaces`
indented.

We can try to stay well below `4 spaces` with anything.
  __
 ( ->  a tweet, ...
 / )\      how sweet <3
<_/_/
 " "

Also, be advised, there is the heredoc we can use a heredoc is a variable
declaration using a self-defined name, here it is `heredoc` which is followed by
the `=` and then three (3) `"""` double quotes.

    heredoc = """

We do just get along so well:
* List item 1
* List item 2
* List item 3

    """

By the way, I will always try to remain within 80 columns but one exception
really, and thats images in Markdown. They can be referenced but directly on one
line so long URLs will mess up the perfection.

> Use a shortcut key to format paragraphs, like #{Alt+Q}


This does make me wonder. Will we want to do anything significant, we need to
read this file - copy (very probably, CS is not really the runtime self
modification but we can simulate by OS processes, forking a subchild and passing
on to that, because from 0 restart this own instance (of `__filename`) is
impossible I think. We will try and explore the bleeding edge, but I'm a bit new
so any pointers could be nice.

Dynamic programming languages are a class of high-level programming languages
that execute at runtime and exhibit many common behaviors that other languages
might perform during compilation, if at all. These behaviors could include
extension of the program, by adding new code, by extending objects and
definitions, or by modifying the type system, all during program execution.
These behaviors can be emulated in nearly any language of sufficient complexity,
but dynamic languages provide direct tools to make use of them. Many of these
features were first implemented as native features in the Lisp programming
language. ![#{source}](http://en.wikipedia.org/wiki/Dynamic_programming_language)

Not all of those things are available to us. I'm not sure all of them yet.

## TODO :: This is the first occurance of a literate CoffeeScript variable.







Advantages of many files in 1 literate document:

* if you happen to use the same words a lot, but never got to setup a
  dictionary, most editors now have auto complete based on that file content and
  words used in the file

__|NOTE|__
* see if you can easily export out that word list eventually, if you plan reuse
  across many seperate books.




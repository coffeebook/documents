# Chapter I

`Coffeebook`, it tells the //whole// story from begin to end. We must already
recognize that, I might have been better off with a Wiki. But I wouldn't get the
code execution too.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
montes, nascetur ridiculus mus.

# Dependency trees

There can be multiple nested dependency trees.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
montes, nascetur ridiculus mus.

## External libraries

After opening the code fences with `\```coffeescript``` so that GitHub Flavored
Markdown (GFM) may recognize it. So I did some thinking and testing of different
notations and what would be easiest. Now what Dr. Knuth did with `tangle` and
`weave` concepts, there is no reason why we cannot have code macros and such in
the same sense of parsing. Anything is possible with node in JavaScript and thus
in CoffeeScript.

But first, lets look at another option: using other code fences to pass on
information to this compiler/unweaver/parser thingie.

```ascii
label:      Custom logger and color levels in winston
class:      example console templates elegant
index:      autonumber, full
views:
print:
```

```coffeescript
\#!/not/a/real/shebang

This is NOT! CoffeeScript. It's still litate CS but GitHub highlight will think
it is. My Sublime won't tho nor will the compiler.

# These are not comments! This is h1!

    # These are comments!

    # label:      Custom logger and color levels in winston
    # class:      example console templates elegant
    # index:      autonumber, full
    # views:
    # print:


    # So this all still runs compatible and free
    winston = require("../lib/winston")

```

It is here where I experimented somewhat with a compatible notation for GFM and
Markdown and literate CoffeeScript and, although not bound by convention, will
try to honor these. Another option is to replace the ASCII text it is now,
by triggering anything after `\```coffeescript` and make it CS. But since we
would be able to moderate ourself (copy the file is probably best) we can play
around as much as we like.

I could have also used a literate method to _|declare|_ a _|new macro|_ in any
fashion inline, we do need have a nice way of compatible parsing. This could be
the coffee compiler to work on special Markdown tags which would in fact be
commands/macros. A convential way of breaking out of comments


    config =
      levels:
        silly: 0
        verbose: 1
        info: 2
        data: 3
        warn: 4
        debug: 5
        error: 6

      colors:
        silly: "magenta"
        verbose: "cyan"
        info: "green"
        data: "grey"
        warn: "yellow"
        debug: "blue"
        error: "red"

    logger = module.exports = new (winston.Logger)(
      transports: [new (winston.transports.Console)(colorize: true)]
      levels: config.levels
      colors: config.colors
    )
    logger.data "hello"



```

> We need auto numbering for references, proper scientific references that is,
> to be properly extracted and parsed to say bibtex.

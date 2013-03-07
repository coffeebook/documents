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
Markdown (GFM) may recognize it.

```ascii
label:      Custom logger and color levels in winston
class:      example console templates elegant
index:      autonumber, full
views:
print:
```

```coffeescript
label:      Custom logger and color levels in winston
class:      example console templates elegant
index:      autonumber, full
views:
print:

    winston = require("../lib/winston")

```

It is here where I experimented somewhat with a compatible notation for GFM and
Markdown and literate CoffeeScript and, although not bound by convention, will
try to honor these. Another option is to replace the ASCII text it is now,
by triggering anything after `\```coffeescript` and make it CS. But since we
would be able to moderate ourself (copy the file is probably best) we can play
around as much as we like.

I could have also used a literate method to {declare} a {macro} in any fashing


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

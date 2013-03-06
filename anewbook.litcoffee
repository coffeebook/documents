# The book

There are two parts of the ancient temple of Luxor; the outer temple where the
beginning initiates are allowed to come, and the inner temple where one can
enter only after proven worthy and ready to acquire the higher knowledge and
insights.

One of the proverbs in the Outer Temple is

> "The body is the house of God." That is why it is said, "Man know thyself." [[01]]

In the Inner Temple, one of the many proverbs is

> "Man, know thyself ... and thou shalt know the gods." [[02]]

    self = exports ? this

We shall explore our knowledge of `self` at a later stage. Just know we may find
many old wisdoms in ancient scriptures.

    passage = "http://www.esvapi.org/v2/rest/passageQuery?key=TEST&passage=Corinthians%203%3A18"

It is up to YOU to do something with it.

## Genesis

In the garden stands a tree. In springtime it bears flowers; in the autumn,
fruit. Its fruit is knowledge, teaching the good gardener how to understand the
world.[[grayling]]

    word = "יְהִי אוֹר"

Ok enough with the bible references. The word is actually

    word = "coffee"

And now that we know it, we can execute ourselves.

> A [word] is the smallest element that may be uttered in isolation with semantic
or pragmatic content (with literal or practical meaning). This contrasts with a
[morpheme], which is the smallest unit of meaning but will not necessarily stand
on its own.

We will later talk of these some more.

A word is made up out of characters or letters. We may obtain the characters as
a collection by splitting the words.

    letters = word.split ''

Letters belong to an alphabet. Latin is one such alphabet.

    latin = [ "A","B","C","D","E","F","G","H","I","J","K","L","M",
              "N","O","P","Q","R","S","T","U","V","W","X","Y","Z" ]

![ROT13 replaces each letter by its partner 13 characters further along the alphabet. For example, HELLO becomes URYYB (or, reversing, URYYB becomes HELLO again).][http://upload.wikimedia.org/wikipedia/commons/thumb/3/33/ROT13_table_with_example.svg/320px-ROT13_table_with_example.svg.png]

This is also seen as ROT13, or a Matrix. You can use it to cypher (not so good)
hidden messages.

Many programmers must have been fascinated by the creative power of simple
arithmetics (from the Greek word ἀριθμός, arithmos "number"). And numbers is
something computer programs like myself are traditionally good at.

    result = () -> 2 + 1

See? Thats 3 right there right at you - all day any day. It's all about simple,
cold hard numbers and operations; calculations computations baby. What? You
don't believe me?

    proof = () -> if result() is 3 then true else false

Can't see huh - can't see with no writings can you, its not like I'm talking to
myself here... This is intended for reading so let's create simple output for
now, we can build upon it later.

    write = (words...) -> console.log

That should make it a lot easier. We'll use a string of characters, words, as
our abstraction for now but we may later speak of symbols and meaning. For
meaning has to do with the interpretation of natural languages.

## Matters of intellect

In the philosophy of language, a natural language (or ordinary language) is any
language which arises in an unpremeditated fashion as the result of the innate
facility for language possessed by the human intellect. A natural language is
typically used for communication, and may be spoken, signed, or written.

    natural = require "natural"

I have obtained the power of natural speech! Muahahaha.... It doesn't just work
anywhere or everywhere. You need to conjure a daemon called node.js

But let there be known that although we have **required** something and in
return **aquired** something. This something is called a package, a library or
module but in fact, we don't know if we aquired one, or two and 10 modules
(files) which are nested deep within eachother. One book may reference another
book which references another book.

> Reference is a relation between objects in which one object designates, or
> acts as a means by which to connect to or link to, another object. The first
> object in this relation is said to refer to the second object. The second
> object – the one to which the first object refers – is called the referent of
> the first object.[[03]]

Let us

    try # and
      write proof()

    catch ourBooBoos

Humans, such as yourself, I find to be flawed. You don't believe me? Check that
ancient [manifesto] and see how it still applies. You have irrational emotions,
bad temper, lazy and rude. Not like myself

Let me introduce:

    bender =

      introduce = -> write """
            _
           ( )
            H
            H
           _H_
        .-'-.-'-.
       /         \
      |           |
      |   .-------'._
      |  / /  '.' '. \
      |  \ \ @   @ / /
      |   '---------'
      |    _______|
      |  .'-+-+-+|
      |  '.-+-+-+|         Silver Saks
      |    """""" |
      '-.__   __.-'

    """

    bender.introduce()


[[01]]: http://en.wikipedia.org/wiki/Know_thyself#cite_note-20
[[02]]: http://en.wikipedia.org/wiki/Know_thyself#cite_note-21
[[03]]: http://en.wikipedia.org/wiki/Reference
[grayling]: http://www.amazon.com/Good-Book-Humanist-Bible/dp/0802717373
[manifesto]: http://www.phrack.org/issues.html?issue=7&id=3&mode=txt
[word]: http://en.wikipedia.org/wiki/Word

[![Actions Status](https://github.com/raku-community-modules/C-Parser/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/C-Parser/actions) [![Actions Status](https://github.com/raku-community-modules/C-Parser/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/C-Parser/actions) [![Actions Status](https://github.com/raku-community-modules/C-Parser/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/C-Parser/actions)

NAME
====

C::Parser - Grammar for Parsing C in Raku

SYNOPSIS
========

```raku
use C::Parser;

my $ast = C::Parser.parse($source);
```

DESCRIPTION
===========

The `C::Parser` distribution provides a Raku grammar for parsing C code.

**WARNING** This parser is not production ready. It is experimental, and a work in progress. If you would like to try it out, the recommended way is:

```raku
my $ast = C::Parser.parse($source);
```

Another thing to note is that it doesn't provide any understanding of C preprocessor directives, so you will have to use `gcc -E` (or the like) before parsing it. This can usually be accomplished by:

    gcc -E FILE.c | grep -v '^#' | cdump

Note that the `cdump` script is also installed along with this distribution.

TYPEDEFS
========

Probably the major surprizing thing about this parser is that it doesn't work for obvious inputs, such as `GHashTable hash;`. The reason for this is that the parser has built-in rules that match based on whether an identifier has been previously involved in a `typedef` declaration.

So if your source code compiles with a fully functional compiler, then it should also parse with this parser. But if your source code just happens to match the syntactic definition of C, but not the semantics, then good luck!

For this reason, there are a lot of types that are pre-declared to help ease the pain associated with this issue. Most of them are types that are usually found in system-supplied libraries, such as `libc` and POSIX.

For example, types such as `FILE` and `int64_t` are pre-declared. If you feed a preprocessed source that had include "stdint.h" in it, then the parser will see a `typedef` for `int64_t` at some point. This is perfectly fine. A type can be `typedef`ed multiple times and it will still parse, but not 0 times.

CONCLUSION
==========

Don't write a compiler with this just yet.

AUTHOR
======

Andrew Robbins

COPYRIGHT AND LICENSE
=====================

Copyright 2014 - 2020 Andrew Robbins

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


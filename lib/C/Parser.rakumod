use C::Parser::Actions;
use C::Parser::Grammar;

unit class C::Parser;

method parse($line) {
    my $actions = C::Parser::Actions.new();
    my $ast = C::Parser::Grammar.parse($line, :$actions);
    $ast ?? $ast.ast !! Nil;
}

=begin pod

=head1 NAME

C::Parser - Grammar for Parsing C in Raku

=head1 SYNOPSIS

=begin code :lang<raku>

use C::Parser;

my $ast = C::Parser.parse($source);

=end code

=head1 DESCRIPTION

The C<C::Parser> distribution provides a Raku grammar for parsing C code.

B<WARNING> This parser is not production ready. It is experimental, and a work in progress.
If you would like to try it out, the recommended way is:

=begin code :lang<raku>

my $ast = C::Parser.parse($source);

=end code

Another thing to note is that it doesn't provide any understanding of C preprocessor
directives, so you will have to use C<gcc -E> (or the like) before parsing it. This
can usually be accomplished by:

=begin output

gcc -E FILE.c | grep -v '^#' | cdump

=end output

Note that the C<cdump> script is also installed along with this
distribution.

=head1 TYPEDEFS

Probably the major surprizing thing about this parser is that it doesn't
work for obvious inputs, such as C<GHashTable hash;>. The reason for
this is that the parser has built-in rules that match based on whether
an identifier has been previously involved in a C<typedef> declaration.

So if your source code compiles with a fully functional compiler, then
it should also parse with this parser. But if your source code just
happens to match the syntactic definition of C, but not the semantics,
then good luck!

For this reason, there are a lot of types that are pre-declared to help
ease the pain associated with this issue. Most of them are types that
are usually found in system-supplied libraries, such as C<libc> and
POSIX.

For example, types such as C<FILE> and C<int64_t> are pre-declared.
If you feed a preprocessed source that had include "stdint.h" in it,
then the parser will see a C<typedef> for C<int64_t> at some point.
This is perfectly fine. A type can be C<typedef>ed multiple times
and it will still parse, but not 0 times.

=head1 CONCLUSION

Don't write a compiler with this just yet.

=head1 AUTHOR

Andrew Robbins

=head1 COPYRIGHT AND LICENSE

Copyright 2014 - 2020 Andrew Robbins

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4

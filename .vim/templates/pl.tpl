#!/usr/bin/env perl

use strict;
use warnings;
use warnings FATAL => "all";
# use diagnostics; # When encountering an error, it will try to explain it.
# use Data::Dumper qw(Dumper);

sub say {
    my $str = shift @_;
    if($str =~ /\n$/) {
        print $str;
    } else {
        print "$str\n";
    }
}

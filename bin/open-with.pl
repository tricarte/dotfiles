#!/usr/bin/perl

use strict;
use warnings;
use File::MimeInfo::Magic;
use File::MimeInfo::Applications;

my $file = $ARGV[0];

my $mimetype = mimetype($file)
|| die "Could not find mimetype for $file\n";

# @other is an array of File::DesktopEntry objects
my ($default, @other) = mime_applications_all($mimetype);

# A trick to remove duplicate entries from @other
my %seen;
my @entries = grep { !$seen{ $_->Name }++ } @other;

# Create the input to fzf
my $output = "";
for (0..$#entries) {
    $output .= sprintf "%d %s\n", $_, $entries[$_]->Name;
}

my $index = `printf "${output}" | fzf --with-nth=2.. --delimiter ' '`;
$entries[(split(/\s/, $index))[0]]->system($file) if $index =~ /^\d+/;

exit;

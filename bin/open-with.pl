#!/usr/bin/perl

use strict;
use warnings;
use File::MimeInfo::Magic;
use File::MimeInfo::Applications;

my $file = $ARGV[0];

die "This script requires a file argument.\n" unless $file;

my $mimetype = mimetype($file)
|| die "Could not find mimetype for $file.\n";

# @other is an array of File::DesktopEntry objects
my ($default, @other) = mime_applications_all($mimetype);

# A trick to remove duplicate entries from @other
my %seen;
my @entries = grep { !$seen{ $_->Name }++ } @other;

# Create the input to fzf in the form:
# N:DesktopEnteryName such as
# 0:LibreOffice Writer
my $output = "";
for (0..$#entries) {
    $output .= sprintf "%d:%s\n", $_, $entries[$_]->Name;
}

# Ask the user
my ( $chosen ) = split /:/, `printf "${output}" | fzf --with-nth=2.. --delimiter ':'`, 2;
# Finally run the selected desktop entry
$entries[$chosen]->system($file) if $chosen;

exit;

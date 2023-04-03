#!/usr/bin/env perl

use strict;
use warnings;
use warnings FATAL => "all";
use 5.34.0;
use JSON qw(decode_json);
# use diagnostics; # When encountering an error, it will try to explain it.
# use Data::Dumper qw(Dumper);
# use HTML::Entities qw(decode_entities);
# use URI::Escape qw(uri_escape);

use DBI;

sub buildSearchQuery {
    my @arraySearch = split / /, shift;
    my $table = shift;
    my $searchFields = shift; # reference hash
    my $selectFields = shift;
    my $mime = shift;
    my $join = shift; # reference array

    my @arrayExecute = ();
    my $mimeSearch = '';

    my $countSearch = scalar @arraySearch;
    my $a = 0;
    my $b = 0;
    my $query = "SELECT $selectFields FROM ".$table;
    if ($join) {
        $query .= " join " . $join->[0] . " on " . $join->[1] . " = " . $join->[2];
    }
    $query .= " WHERE ((";
    my $countFields = scalar %{$searchFields};

    while ($a < $countFields) {
        while ($b < $countSearch) {
            $query .= "$searchFields->{$a} LIKE ?";
            push @arrayExecute, "%$arraySearch[$b]%";
            $b++;
            if ($b < $countSearch) {
                $query .= " AND ";
            }
        }
        $b = 0;
        $a++;
        if ($a < $countFields) {
            $query .= ") OR (";
        }
    }

    if($mime)
    {
        $mimeSearch = 'AND (' . $table . '.type LIKE ? OR snpy_category.title LIKE ?)';
        push @arrayExecute, "%$mime%";
        push @arrayExecute, "%$mime%";
    }

    $query .= ')) AND ' . $table . '.deleted = 0 ' . $mimeSearch . ' order by ' . $table . '.title asc';
    return ( \$query, \@arrayExecute );
}

# Handle input
push @ARGV, <STDIN> if -p STDIN; # Now we accept stdin also
my $arg = join ' ', @ARGV;
my $input = undef;
if ( $arg ne '' ) {
    $input = $arg;
} else {
    print "Enter the search query: ";
    $input = <STDIN>;
}
chomp $input;
my ($mime, $qstring) = $input =~ /:/ ? ( split /:/, $input ) : ( '', $input );

# Connect to database
my $dsn = "dbi:SQLite:dbname=$ENV{'HOME'}/bin/database_with_date.sqlite";
my $dbh = DBI->connect($dsn, "", "", {
        PrintError => 0,
        RaiseError => 1,
        AutoCommit => 1,
        FetchHashKeyName => 'NAME_lc',
    });

my ($query, $bindings) = buildSearchQuery(
    $qstring,
    "snpy_snippet",
    {
        0 => "snpy_snippet.title",
        1 => "snpy_snippet.description",
        2 => "snpy_snippet.content"
    },
    "snpy_snippet.id, snpy_category.title || ' - ' || snpy_snippet.title as concatTitle, snpy_snippet.content, snpy_snippet.parent_id",
    $mime,
    [ "snpy_category", "snpy_category.id", "snpy_snippet.parent_id" ]
);

my $sth = $dbh->prepare($$query);
$sth->execute(@{$bindings});

my $fzfinput = "";
my %results= ();
while (my @row = $sth->fetchrow_array) {
    $results{$row[0]} = $row[2]; # id => snippet_content pair
    $fzfinput .= sprintf "%d::%s\n", $row[0], $row[1];
}

my ( $chosen ) = split /::/, `printf "${fzfinput}" | fzf --with-nth=2.. --nth=1.. --delimiter='::'`, 2;

say $results{$chosen} if $chosen;

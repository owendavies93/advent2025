#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day1';
$file = "inputs/day1-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
my $start = 50;
while (<$fh>) {
    chomp;
    my ($dir, $mag) = /(L|R)(\d+)/;

    if ($dir eq 'L') {
        $start = ($start - $mag) % 100;
    } else {
        $start = ($start + $mag) % 100;
    }

    $total ++ if $start == 0;
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

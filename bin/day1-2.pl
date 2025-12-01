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

    for (1..$mag) {
        if ($dir eq 'L') {
            $start = ($start - 1) % 100;
        } else {
            $start = ($start + 1) % 100;
        }
        
        if ($start == 0) {
            $total++;
        }
    }
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

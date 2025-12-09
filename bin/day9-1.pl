#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day9';
$file = "inputs/day9-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
my @tiles;
while (<$fh>) {
    chomp;
    my ($x,$y) = split /,/;
    push @tiles, [$x, $y];
}

for my $t (@tiles) {
    for my $t2 (@tiles) {
        my ($x1,$y1) = @$t;
        my ($x2,$y2) = @$t2;
        next if $x1 == $x2 && $y1 == $y2;

        my $area = (1 + abs($x1 - $x2)) * (1 + abs($y1 - $y2));
        if ($area > $total) {
            $total = $area;
        }
    }
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

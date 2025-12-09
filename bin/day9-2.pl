#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

use List::AllUtils qw(:all);

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
            my $candidate = 1;
            
            my $minx = min($x1, $x2);
            my $miny = min($y1, $y2);
            my $maxx = max($x1, $x2);
            my $maxy = max($y1, $y2);
            
            for (my $i = 0; $i <= $#tiles; $i++) {
                my ($xi, $yi) = @{$tiles[$i]};
                my $ni = ($i + 1) % $#tiles;
                my ($xni, $yni) = @{$tiles[$ni]};

                my $inside = (
                    ($xi >= $maxx && $xni >= $maxx) ||
                    ($xi <= $minx && $xni <= $minx) ||
                    ($yi >= $maxy && $yni >= $maxy) ||
                    ($yi <= $miny && $yni <= $miny)
                );
                
                $candidate = 0 if !$inside; 
            }

            if ($candidate == 1) {
                $total = $area;
            }
        }
    }
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

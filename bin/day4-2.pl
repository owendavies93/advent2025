#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Grid::Dense::Diagonal;
use Advent::Grid::Utils qw(get_grid);
use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day4';
$file = "inputs/day4-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;

my ($grid, $width, $height) = get_grid($fh);

my $g = Advent::Grid::Dense::Diagonal->new({
    grid => $grid,
    width => $width,
});

while (1) {
    my $sub = 0;
    for my $y (0..$height - 1) {
        for my $x (0..$width - 1) {
            my $i = $y * $width + $x;
            next unless $g->get_at_index($i) eq '@';

            my @ns = $g->neighbour_vals_from_index($i);
            my $count = grep { $_ eq '@' } @ns;

            if ($count < 4) {
                $total++;
                $sub++;
                $g->set_at_index($i, '.');
            }
        }
    }
    last if $sub == 0;
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

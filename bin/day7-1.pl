#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Grid::Utils qw(get_grid);
use Advent::Utils::Problem qw(submit);

use List::AllUtils qw(:all);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day7';
$file = "inputs/day7-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
my ($grid, $width, $height) = get_grid($fh);

my $next = {};
my $splitters = {};

for my $y (0..$height - 1) {
    for my $x (0..$width - 1) {
        my $i = $y * $width + $x;
        if ($grid->[$i] eq 'S') {
            $next = { $x => 1 };
        } elsif ($grid->[$i] eq '^') {
            push @{$splitters->{$y}}, $x;
        }
    }
}

for my $y (0..$height - 1) {
    next unless exists $splitters->{$y};
    my @sps = @{$splitters->{$y}};

    for my $s (@sps) {
        if ($next->{$s}) {
            if ($s > 0) {
                $next->{$s - 1} = 1;
            }
            if ($s < $height - 1) {
                $next->{$s + 1} = 1;
            }

            delete $next->{$s};

            $total++;
        }
    }
}


if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

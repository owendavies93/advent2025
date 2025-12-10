#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

use List::AllUtils qw(:all);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day10';
$file = "inputs/day10-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
while (<$fh>) {
    chomp;
    my ($state, $buttons) = /\[([^\]]+)\]\s+\(([^\{]+)\)(.*)/; 
    my $end_state = oct('0b' . join '', reverse map { $_ eq '#' ? 1 : 0 } split //, $state);
    my @buttons = map { [ split /,/ ] } split /\)\s+\(/, $buttons;

    @buttons = map { sum map { 2**$_ } @$_ } @buttons;
    
    my @q = ([0, 0]);
    my $seen = {};

    while (@q) {
        my $c = shift @q;
        my ($state, $steps) = @$c;

        if ($state == $end_state) { 
            $total += $steps;
            last;
        }

        for my $b (@buttons) {
            my $new = $state ^ $b;
            next if $seen->{$new};
            $seen->{$new} = 1;
            push @q, [$new, $steps + 1];
        }
    }
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

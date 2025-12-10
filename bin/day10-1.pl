#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day10';
$file = "inputs/day10-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
while (<$fh>) {
    chomp;

    my ($state, $buttons) = /\[([^\]]+)\]\s+\(([^\{]+)\)(.*)/; 
    my @end_state = map { $_ eq '#' ? 1 : 0 } split //, $state;
    my @buttons = map { [ split /,/ ] } split /\)\s+\(/, $buttons;
    my @start = map { 0 } @end_state;
    
    my @q = ([\@start, 0]);
    my $seen = {};

    while (@q) {
        my $c = shift @q;
        my ($state, $steps) = @$c;

        my $x = join '', @$state;
        if ($x eq join '', @end_state) {
            $total += $steps;
            last;
        }

        for my $b (@buttons) {
            my $new = update_state($state, $b);
            my $k = join '', @$new;
            next if $seen->{$k};
            $seen->{$k} = 1;
            push @q, [$new, $steps + 1];
        }
    }
}

sub update_state {
    my ($state, $b) = @_;

    my @new = @$state;
    for my $num (@$b) {
        $new[$num] = $state->[$num] == 1 ? 0 : 1;
    }

    return \@new;
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

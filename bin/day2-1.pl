#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day2';
$file = "inputs/day2-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
while (<$fh>) {
    chomp;
    my @ranges = split /,/;

    for my $r (@ranges) {
        my ($from, $to) = split /-/, $r;
        for my $i ($from..$to) {
            my $l = length $i;
            next if $l % 2 != 0;

            my $front = substr $i, 0, $l / 2;
            my $back = substr $i, $l / 2;

            if ($front eq $back) {
                $total += $i;
            }
        }
    }

}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

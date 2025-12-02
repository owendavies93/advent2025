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

            for my $div (2..$l) {
                next if $l % $div != 0;

                my @parts;
                my $seg_length = $l / $div;
                my $offset = 0;
                for my $seg (1..$div) {
                    push @parts, substr $i, $offset, $seg_length;
                    $offset += $seg_length;
                }

                my %parts = map { $_, 1 } @parts;
                if (keys %parts == 1) {
                    $total += $i;
                    last;
                }
            }
        }
    }

}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

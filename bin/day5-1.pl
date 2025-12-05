#!/usr/bin/env perl
use Mojo::Base -strict;

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day5';
$file = "inputs/day5-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;

my @ranges;
while (<$fh>) {
    chomp;
    last if !$_;

    my ($first, $last) = /(\d+)-(\d+)/;
    push @ranges, [$first, $last];
}

@ranges = sort { $a->[0] <=> $b->[0] } @ranges;

my @ings;
while (<$fh>) {
    chomp;
    push @ings, $_;
}

my $i = 0;

for my $i (@ings) {
    for my $mr (@ranges) {
        my ($s, $e) = @$mr;
        if ($i >= $s && $i <= $e) {
            $total++;
            last;
        }
    }
}

say $total;

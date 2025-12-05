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

my @merged_ranges;
for my $r (@ranges) {
    my ($ns, $ne) = @$r;

    my $merged = 0;
    for my $mr (@merged_ranges) {
        my ($s, $e) = @$mr;
        if ($s <= $ns && $ne <= $e) {
            $merged = 1;
        } elsif ($s <= $ns && $ns <= $e && $ne >= $e) {
            $mr->[1] = $ne;
            $merged = 1;
        }
    }

    if (scalar @merged_ranges == 0 || $merged == 0) {
        push @merged_ranges, [$ns, $ne];
    }
}

for my $r (@merged_ranges) {
    my ($s, $e) = @$r;
    $total += (1 + $e - $s);
}

say $total;


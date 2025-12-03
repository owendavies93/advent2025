#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day3';
$file = "inputs/day3-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
while (<$fh>) {
    chomp;
    my @batteries = split //;

    my $digits = 1;
    my $length = 2;
    my $start = 0;
    my $num = '';
    while ($digits <= 2) {
        my ($max, $mi) = max_in_range($start, $#batteries - ($length - $digits), \@batteries);
        $num .= $max;
        $start = $mi + 1;
        $digits++;
    }

    $total += $num;
}

sub max_in_range {
    my ($start, $end, $range) = @_;

    my $max = 0;
    my $mi = 0;
    for my $i ($start..$end) {
        if ($range->[$i] > $max) {
            $max = $range->[$i];
            $mi = $i;
        }
    }

    return ($max, $mi);
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

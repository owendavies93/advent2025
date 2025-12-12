#!/usr/bin/env perl
use Mojo::Base -strict;

use Memoize;

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day11';
$file = "inputs/day11-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;

my $total = 0;
my $edges = {};
while (<$fh>) {
    chomp;
    my ($s, $e) = split /:\s+/;
    $edges->{$s} = [split /\s+/, $e];
}

$total = count('svr', 0, 0);
say $total;

memoize('count');
sub count {
    my ($node, $seen_dac, $seen_fft) = @_;

    if ($node eq 'out') {
        return $seen_dac == 1 && $seen_fft == 1 ? 1 : 0;
    }

    my $count = 0;
    my $n_seen_dac = $seen_dac;
    $n_seen_dac = 1 if $node eq 'dac';
    my $n_seen_fft = $seen_fft;
    $n_seen_fft = 1 if $node eq 'fft';

    for my $e (@{$edges->{$node}}) {
        $count += count($e, $n_seen_dac, $n_seen_fft);
    }
    return $count;
}

#!/usr/bin/env perl
use Mojo::Base -strict;

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

$total = count('you', []);
say $total;

sub count {
    my ($node, $curr) = @_;

    return 1 if $node eq 'out';

    my $count = 0;
    for my $e (@{$edges->{$node}}) {
        $count += count($e, $curr);
    }
    return $count;
}

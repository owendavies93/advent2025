#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

use List::AllUtils qw(:all);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day6';
$file = "inputs/day6-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
my @eqs;
my @ops;
while (<$fh>) {
    chomp;
    s/^\s+//;
    if (/\*|\+/) {
        @ops = split /\s+/;
        last;
    }
    my @nums = split /\s+/;

    for (my $i = 0; $i <= $#nums; $i++) {
        if (!$eqs[$i]) {
            $eqs[$i] = [];
        }
        push @{$eqs[$i]}, $nums[$i];
    }
}

for (my $i = 0; $i <= $#ops; $i++) {
    my $o = $ops[$i];
    my $e = $eqs[$i];

    if ($o eq '+') {
        $total += sum @$e;
    } else {
        $total += product @$e;
    }
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

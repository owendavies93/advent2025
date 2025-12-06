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
    if (/\*|\+/) {
        @ops = split /\s+/;
        last;
    }
    my @nums = split //;

    for (my $i = 0; $i <= $#nums; $i++) {
        if (!$eqs[$i]) {
            $eqs[$i] = [];
        }
        push @{$eqs[$i]}, $nums[$i];
    }
}

@eqs = reverse @eqs;
@ops = reverse @ops;

my $i = 0;
for my $o (@ops) {
    my @group;
    my $num = join "", @{$eqs[$i]};
    while ($num !~ /^\s+$/) {
        push @group, int($num);
        $i++;
        last if $i > $#eqs;
        $num = join "", @{$eqs[$i]};
    }

    if ($o eq '+') {
        $total += sum @group;
    } else {
        $total += product @group;
    }

    $i++;
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

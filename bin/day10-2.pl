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

    my ($state, $buttons, $jolts) = /\[([^\]]+)\]\s+\(([^\{]+)\)\s+\{(.*)\}/; 
    
    my @buttons = map { [ split /,/ ] } split /\)\s+\(/, $buttons;
    my @jolts = split /,/, $jolts;

    my $objective = join ' + ', map { "x$_" } (0..$#buttons);
    my $vars = '{' . (join ', ', map { "x$_" } (0..$#buttons)) . '}';

    my $cons = '';
    for (my $i = 0; $i <= $#jolts; $i++) {
        my $j = $jolts[$i];

        my @con;
        for (my $bi = 0; $bi <= $#buttons; $bi++) {
            my $b = $buttons[$bi];
            if (grep { $_ == $i } @$b) {
                push @con, "x$bi";
            }
        }

        $cons .= join " + ", @con;
        $cons .= " == $j,\n";
    }

    $cons .= join ', ', map { "x$_ >= 0" } (0..$#buttons);

    my $func = qq(
Minimize[
    { $objective,
        {
         $cons,

         Element[$vars, Integers]
        }
    },
    $vars
    ]
    );

    my $soln = `wolframscript -code "$func"`;
    my ($presses) = $soln =~ /^\{(\d+)/;
    $total += $presses;
}

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}


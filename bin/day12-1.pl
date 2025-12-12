#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day12';
$file = "inputs/day12-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;
my $shapes = {};
my $cur = 0;
my @regions; 
while (<$fh>) {
    chomp;
    if (my ($id) = $_ =~ /^(\d+):/) {
        $cur = $id;
        $shapes->{$cur} = {};
    } elsif (/[#.]+/) {
        $shapes->{$cur}->{width} = length($_);
        $shapes->{$cur}->{length}++;
    } elsif (!$_) {
        next;
    } elsif (/^\d+x\d+/) {
        my ($width, $length, $qs) = /^(\d+)x(\d+):\s+(.*)$/;

        my @qs = split /\s+/, $qs;
        my $quans = {};
        for (my $i = 0; $i <= $#qs; $i++) {
            $quans->{$i} = $qs[$i]; 
        }

        push @regions, {
            width => $width,
            length => $length,
            qs => $quans,
        };
    }
}

for my $r (@regions) {
    my $w = $r->{width};
    my $l = $r->{length};

    my $total_area = 0;

    for my $q (keys %{$r->{qs}}) {
        my $quan = $r->{qs}->{$q};
        my $a = $shapes->{$q}->{width} * $shapes->{$q}->{length};
        $total_area += ($a * $quan);
    }

    my $area = $w * $l;
    my $diff = $area - $total_area;
    $total++ if $diff >= 0;
}

say $total;

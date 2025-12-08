#!/usr/bin/env perl
use Mojo::Base -strict;

use lib "../cheatsheet/lib";

use Advent::Utils::Problem qw(submit);

my $file = defined $ARGV[0] ? $ARGV[0] : 'inputs/day8';
$file = "inputs/day8-$file" if $file =~ /test/;
open(my $fh, '<', $file) or die $!;
my $total = 0;

my @points;
while (<$fh>) {
    chomp;
    my ($x, $y, $z) = split /,/;
    my $p = Advent::Point::Point3->new($x, $y, $z);
    push @points, $p;
}

my $lim = $file =~ /test/ ? 10 : 1000;

my $dists = {};
for (my $i = 0; $i <= $#points; $i++) {
   for (my $j = $i + 1; $j <= $#points; $j++) {
        my $p = $points[$i];
        my $p2 = $points[$j];
        my $d = $p->dist($p2);
        $dists->{$d} = [$i, $j]; 
    }
}

my @dists = sort { $a <=> $b } keys %$dists;

my $parents = {};
for (my $i = 0; $i <= $#points; $i++) {
    $parents->{$i} = $i;
}

for (my $i = 0; $i < $lim; $i++) {
    my $d = $dists[$i];
    my ($x, $y) = @{$dists->{$d}};
    merge($x, $y);
}

my $sizes = {};
for (my $i = 0; $i <= $#points; $i++) {
    $sizes->{find($i)}++;
}

my @sizes = sort { $b <=> $a } values %$sizes;
$total = $sizes[0] * $sizes[1] * $sizes[2];

if ($file !~ /test/) {
    submit($total);
} else {
    say $total;
}

sub find {
    my $x = shift;
    return $x if $x == $parents->{$x};
    $parents->{$x} = find($parents->{$x});
    return $parents->{$x};
}

sub merge {
    my ($x, $y) = @_;
    $parents->{find($x)} = find($y);
}

package Advent::Point::Point3;

sub new {
    my ($class, $x, $y, $z) = @_;

    my $self = {
        x => $x,
        y => $y,
        z => $z,
    };
    bless $self, $class;
    return $self;
}

sub dist {
    my ($self, $p) = @_;
    my $dx = ($self->x - $p->x)**2;
    my $dy = ($self->y - $p->y)**2;
    my $dz = ($self->z - $p->z)**2;
    return sqrt($dx + $dy + $dz);
}

sub x { my $self = shift; return $self->{x} };
sub y { my $self = shift; return $self->{y} };
sub z { my $self = shift; return $self->{z} };

1;

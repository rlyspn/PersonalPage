#!/usr/bin/perl

use v5.10;

use strict;
use warnings;

my $assets = "assets";
my $css = "$assets/css/style.css";
my $pd = "pandoc --from=markdown --to=html -c=assets/css/style.css"

print "Hello World\n";
print "assets = $assets\n";
print "css = $css\n";


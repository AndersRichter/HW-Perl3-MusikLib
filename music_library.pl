#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use DDP;

use VivodTablic;
use Sortirovchik;
use Reshatel;

my @dar = sosdanie();
resh(@dar);

1;

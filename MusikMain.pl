use strict;
use warnings;
use diagnostics;
use DDP;

use VivodTablic;
use Sortirovchik;
use Reshatel;

my @dar = sosdanie();
my $len = sosdanie();

@dar = resh($len, @dar);

1;

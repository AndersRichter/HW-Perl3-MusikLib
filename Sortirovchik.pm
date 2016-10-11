package Local::Sortirovchik;
BEGIN
{
	use strict;
	use warnings;
	use Exporter 'import';
	#our @ISA = "Exporter";
	our @EXPORT = qw(&sortirovka_band &sortirovka_year &sortirovka_album &sortirovka_track &sortirovka_form);
}

sub sortirovka_band
{
	my (@arr) = @_;
	
	my $len = 0;
	while($arr[$len])
	{$len++;}
	
	for (my $i=0; $i < ($len-1); $i++)
	{
		my $k = 0;
		for (my $j=0; $j < ($len-$i-1); $j++)
		{
			if ($arr[$j][0] gt $arr[$j+1][0]) 
			{
				my $b = $arr[$j];
				$arr[$j] = $arr[$j+1];
				$arr[$j+1] = $b;
				$k = 1;
			}
		}
		if($k == 0) {last;}
	}	
	return @arr;
}

sub sortirovka_year
{
	my (@arr) = @_;
	
	my $len = 0;
	while($arr[$len])
	{$len++;}
	
	for (my $i=0; $i < ($len-1); $i++)
	{
		my $k = 0;
		for (my $j=0; $j < ($len-$i-1); $j++)
		{
			if ($arr[$j][1] > $arr[$j+1][1]) 
			{
				my $b = $arr[$j];
				$arr[$j] = $arr[$j+1];
				$arr[$j+1] = $b;
				$k = 1;
			}
		}
		if($k == 0) {last;}
	}	
	return @arr;
}	

sub sortirovka_album
{
	my (@arr) = @_;
	
	my $len = 0;
	while($arr[$len])
	{$len++;}
	
	for (my $i=0; $i < ($len-1); $i++)
	{
		my $k = 0;
		for (my $j=0; $j < ($len-$i-1); $j++)
		{
			if ($arr[$j][2] gt $arr[$j+1][2]) 
			{
				my $b = $arr[$j];
				$arr[$j] = $arr[$j+1];
				$arr[$j+1] = $b;
				$k = 1;
			}
		}
		if($k == 0) {last;}
	}	
	return @arr;
}

sub sortirovka_track
{
	my (@arr) = @_;
	
	my $len = 0;
	while($arr[$len])
	{$len++;}
	
	for (my $i=0; $i < ($len-1); $i++)
	{
		my $k = 0;
		for (my $j=0; $j < ($len-$i-1); $j++)
		{
			if ($arr[$j][3] gt $arr[$j+1][3]) 
			{
				my $b = $arr[$j];
				$arr[$j] = $arr[$j+1];
				$arr[$j+1] = $b;
				$k = 1;
			}
		}
		if($k == 0) {last;}
	}	
	return @arr;
}

sub sortirovka_form
{
	my (@arr) = @_;
	
	my $len = 0;
	while($arr[$len])
	{$len++;}
	
	for (my $i=0; $i < ($len-1); $i++)
	{
		my $k = 0;
		for (my $j=0; $j < ($len-$i-1); $j++)
		{
			if ($arr[$j][4] gt $arr[$j+1][4]) 
			{
				my $b = $arr[$j];
				$arr[$j] = $arr[$j+1];
				$arr[$j+1] = $b;
				$k = 1;
			}
		}
		if($k == 0) {last;}
	}	
	return @arr;
}

return 1;
END{}

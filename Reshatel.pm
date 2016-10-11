package Reshatel;
BEGIN
{
	use strict;
	use warnings;
	use DDP;
	use VivodTablic;
	use Sortirovchik;
	use Exporter();
	our @ISA = "Exporter";
	our @EXPORT = qw(&resh);
}

sub resh
{
	my ($len, @arr) = @_;
	
	my $qwe = join (" ", @ARGV);
	my @res=split /(?:-)/,$qwe;
	my @kol;
	my $ind = 0;
	for (my $i=0; $i<= $#res; $i++)
	{		
		if ($res[$i] eq "")
		{
			splice(@res,$i,1);
			$i--;
		}
		$res[$i]=~ s/[ ]$//;
	}
	
	for (my $i=0; $i<= $#res; $i++)
	{
		$res[$i]=~ /^(\w+)/;
		if($1 eq "band") 
		{
			$res[$i]=~ /'(?<ban>\N+)'/;
			@arr = ost_band($len, $+{ban}, @arr);
		}
		if($1 eq "year")
		{
			$res[$i]=~ /'(?<yea>\N+)'/;
			@arr = ost_year($len, $+{yea}, @arr);
		}
		if($1 eq "album")
		{
			$res[$i]=~ /'(?<alb>\N+)'/;
			@arr = ost_album($len, $+{alb}, @arr);;
		}
		if($1 eq "track")
		{
			$res[$i]=~ /'(?<tra>\N+)'/;
			@arr = ost_track($len, $+{tra}, @arr);
		}
		if($1 eq "format")
		{
			$res[$i]=~ /'(?<for>\N+)'/;
			@arr = ost_form($len, $+{for}, @arr);
		}
		if($1 eq "columns") 
		{
			$res[$i]=~ s/columns //;
			pechat_kol($len, @arr);
			$ind = 1;
		}
		if($1 eq "sort") 
		{
			$res[$i]=~ /(?<sor>\w+)$/;
			if($+{sor} eq "band")	{@arr = sortirovka_band($len, @arr);}
			if($+{sor} eq "year")	{@arr = sortirovka_year($len, @arr);}
			if($+{sor} eq "album")	{@arr = sortirovka_album($len, @arr);}
			if($+{sor} eq "track")	{@arr = sortirovka_track($len, @arr);}
			if($+{sor} eq "format")	{@arr = sortirovka_form($len, @arr);}
		}
	}
	if($ind == 0) {pechat($len, @arr);}
	return @arr;
}

return 1;
END{}

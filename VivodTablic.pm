package VivodTablic;
BEGIN
{
	use strict;
	use warnings;
	use DDP;
	use Exporter();
	our @ISA = "Exporter";
	our @EXPORT = qw(&sosdanie &pechat &ost_band &ost_year &ost_album &ost_track &ost_form &pechat_kol);
}

sub sosdanie
{
	my $filename = 'Mus.txt';

	open(my $fh, '<:encoding(UTF-8)', $filename)
	  or die "Could not open file '$filename' $!";

	my @arr;
	my $w=0;
	 
	while (my $row = <$fh>) 
	{
		chomp $row;
		$row=~ s/\.\///;
		my @spli=split /(?:(\/)|(\d+\s\-\s)|(\.))/,$row;
		
		for (my $i=0; $i<= $#spli; $i++)
		{		
			if (!defined($spli[$i]))
			{
				splice(@spli,$i,1);
				$i--;
			}
			elsif($spli[$i]=~/^$/)
			{			
				splice(@spli,$i,1);
				$i--;
			}
			elsif($spli[$i]=~/^\/$/)
			{			
				splice(@spli,$i,1);
				$i--;
			}
			elsif($spli[$i]=~/^(\d+)\s\-\s$/)
			{	
				$spli[$i] = $1;
				$i--;
			}
			elsif($spli[$i]=~/^\.$/)
			{			
				splice(@spli,$i,1);
				$i--;
			}
		}	
		
		my $group = $spli[0];
		my $year = $spli[1];
		my $album = $spli[2];
		my $trek = $spli[3];
		my $form = $spli[4];	
		$arr[$w] = ( [$group,$year,$album,$trek,$form] );
		$w++;
	}
	return @arr;
	return $w;
}

sub pechat
{
	my ($w, @arr) = @_;
	my $maxgroup = 0;
	my $maxalbum = 0;
	my $maxtrek = 0;

	for (my $i=0; $i< $w; $i++)
	{
		if($arr[$i][0] ne "0")
		{
			my $gr = length($arr[$i][0]);
			if($gr > $maxgroup) {$maxgroup = $gr;}
		}
	}
	for (my $i=0; $i< $w; $i++)
	{
		if($arr[$i][0] ne "0")
		{
			my $al = length($arr[$i][2]);
			if($al > $maxalbum) {$maxalbum = $al;}
		}
	}
	for (my $i=0; $i< $w; $i++)
	{
		if($arr[$i][0] ne "0")
		{
			my $tr = length($arr[$i][3]);
			if($tr > $maxtrek) {$maxtrek = $tr;}
		}
	}
	for (my $j=0; $j < $w; $j++)
	{
		if (($arr[$j][0] ne "0")&&($arr[$j][1] ne "0")&&($arr[$j][2] ne "0")&&($arr[$j][3] ne "0")&&($arr[$j][4] ne "0"))
		{
			print "/";
			for (my $i=0; $i < ($maxtrek+$maxalbum+$maxgroup+21); $i++)
			{
				print "-";
			}
			print "\\\n";
			last;
		}
	}

	for (my $i=0; $i < $w; $i++)
	{
		if (($arr[$i][0] ne "0")&&($arr[$i][1] ne "0")&&($arr[$i][2] ne "0")&&($arr[$i][3] ne "0")&&($arr[$i][4] ne "0"))
		{
			print "| ";
			if(length($arr[$i][0]) < $maxgroup)
			{
				for(my $j=0; $j < ($maxgroup-length($arr[$i][0])); $j++)
				{print " ";}
				print $arr[$i][0];
			}
			else {print $arr[$i][0];}	
			print " | $arr[$i][1] | ";	
			if(length($arr[$i][2]) < $maxalbum)
			{
				for(my $j=0; $j < ($maxalbum-length($arr[$i][2])); $j++)
				{print " ";}
				print $arr[$i][2];
			}
			else {print $arr[$i][2];}	
			print " | ";
			if(length($arr[$i][3]) < $maxtrek)
			{
				for(my $j=0; $j < ($maxtrek-length($arr[$i][3])); $j++)
				{print " ";}
				print $arr[$i][3];
			}
			else {print $arr[$i][3];}	
			print " | $arr[$i][4] |\n";	
			if($i == ($w-1))
			{
				print "\\";
				for (my $j=0; ($j < $maxgroup+2); $j++)	{print "-";}
				print "+------+";		
				for (my $j=0; ($j < $maxalbum+2); $j++)	{print "-";}
				print "+";
				for (my $j=0; ($j < $maxtrek+2); $j++)	{print "-";}
				print "+-----/\n";
			}
			else
			{
				print "|";
				for (my $j=0; ($j < $maxgroup+2); $j++)	{print "-";}
				print "+------+";		
				for (my $i=0; ($i< $maxalbum+2); $i++)	{print "-";}
				print "+";
				for (my $i=0; ($i< $maxtrek+2); $i++)	{print "-";}
				print "+-----|\n";
			}
		}
		else {};
	}
}

sub ost_band
{
	my ($w, $str, @arr) = @_;
	my $id = 0;

	for (my $i=1; $i < $w+1; $i++)
	{	
		if ($arr[$i-1][0] ne $str)
		{
			$arr[$i-1][0] = 0;
			$arr[$i-1][1] = 0;
			$arr[$i-1][2] = 0;
			$arr[$i-1][3] = 0;
			$arr[$i-1][4] = 0;
			$id++;
		}
	}
	if($id == $w)
	{print ("Error, no file with this band\n");}
	return @arr;
}

sub ost_year
{
	my ($w, $str, @arr) = @_;
	my $id = 0;

	for (my $i=1; $i < $w+1; $i++)
	{	
		if ($arr[$i-1][1] != $str)
		{
			$arr[$i-1][0] = 0;
			$arr[$i-1][1] = 0;
			$arr[$i-1][2] = 0;
			$arr[$i-1][3] = 0;
			$arr[$i-1][4] = 0;
			$id++;
		}
	}
	if($id == $w)
	{print ("Error, no file with this year\n");}
	return @arr;
}

sub ost_album
{
	my ($w, $str, @arr) = @_;
	my $id = 0;

	for (my $i=1; $i < $w+1; $i++)
	{	
		if ($arr[$i-1][2] ne $str)
		{
			$arr[$i-1][0] = 0;
			$arr[$i-1][1] = 0;
			$arr[$i-1][2] = 0;
			$arr[$i-1][3] = 0;
			$arr[$i-1][4] = 0;
			$id++;
		}
	}
	if($id == $w)
	{print ("Error, no file with this album\n");}
	return @arr;
}

sub ost_track
{
	my ($w, $str, @arr) = @_;
	my $id = 0;

	for (my $i=1; $i < $w+1; $i++)
	{	
		if ($arr[$i-1][3] ne $str)
		{
			$arr[$i-1][0] = 0;
			$arr[$i-1][1] = 0;
			$arr[$i-1][2] = 0;
			$arr[$i-1][3] = 0;
			$arr[$i-1][4] = 0;
			$id++;
		}
	}
	if($id == $w)
	{print ("Error, no file with this track\n");}
	return @arr;
}

sub ost_form
{
	my ($w, $str, @arr) = @_;
	my $id = 0;

	for (my $i=1; $i < $w+1; $i++)
	{	
		if ($arr[$i-1][4] ne $str)
		{
			$arr[$i-1][0] = 0;
			$arr[$i-1][1] = 0;
			$arr[$i-1][2] = 0;
			$arr[$i-1][3] = 0;
			$arr[$i-1][4] = 0;
			$id++;
		}
	}
	if($id == $w)
	{print ("Error, no file with this format\n");}
	return @arr;
}

sub pechat_kol
{
	my ($len, @arr) = @_;
	my $maxgroup = 0;
	my $maxalbum = 0;
	my $maxtrek = 0;
	my $maxmax = 0;	
	my @kol;
	my $ind = 0;
	my $in = 0;
	my $dl = 0;
	my $stroka = "";
	
	my $qwe = join (" ", @ARGV);
	my @res=split /(?:-)/,$qwe;
	
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
		if($1 eq "columns") 
		{
			$res[$i]=~ s/columns //;
			@kol = split /(?:,)/,$res[$i];
		}
	}
	
	for (my $i=0; $i< $len; $i++)
	{
		my $gr = length($arr[$i][0]);
		if($gr > $maxgroup) {$maxgroup = $gr;}
	}
	for (my $i=0; $i< $len; $i++)		
	{
		my $al = length($arr[$i][2]);
		if($al > $maxalbum) {$maxalbum = $al;}
	}
	for (my $i=0; $i< $len; $i++)
	{
		my $tr = length($arr[$i][3]);
		if($tr > $maxtrek) {$maxtrek = $tr;}
	}

	for (my $i=0; $i <= $#kol; $i++)
	{
		if($kol[$i] eq "band")		{$maxmax = $maxmax + $maxgroup + 3;}
		if($kol[$i] eq "year")		{$maxmax = $maxmax + 7;}
		if($kol[$i] eq "album")		{$maxmax = $maxmax + $maxalbum + 3;}
		if($kol[$i] eq "track")		{$maxmax = $maxmax + $maxtrek + 3;}
		if($kol[$i] eq "format")	{$maxmax = $maxmax + 6;}
	}	
	print "/";
	for (my $i=0; $i < $maxmax-1; $i++)
	{
		print "-";
	}
	print "\\\n";
	
	for (my $i=0; $i< $len; $i++)
	{
		if (($arr[$i][0] ne "0")&&($arr[$i][1] ne "0")&&($arr[$i][2] ne "0")&&($arr[$i][3] ne "0")&&($arr[$i][4] ne "0"))	{$dl++;}
	}
	
	for (my $i=0; $i < $len; $i++)
	{
		if($in == $dl-1) {$stroka = "\\";}
		else {$stroka = "|";}
		
		if (($arr[$i][0] ne "0")&&($arr[$i][1] ne "0")&&($arr[$i][2] ne "0")&&($arr[$i][3] ne "0")&&($arr[$i][4] ne "0"))
		{
			$in++;
			print "| ";
			for (my $j=0; $j <= $#kol; $j++)
			{
				#print "st $stroka\n";
				#print "el $kol[$j]\n";
				if($j == $#kol)
				{
					$ind = 1;
					if($kol[$j] eq "band")
					{
						if(length($arr[$i][0]) < $maxgroup)
						{
							for(my $j=0; $j < ($maxgroup-length($arr[$i][0])); $j++)
							{print " ";}
							print "$arr[$i][0] | \n";
						}
						else {print "$arr[$i][0] | \n";}
					}
					if($kol[$j] eq "year")
					{
						print "$arr[$i][1] | \n";
					}
					if($kol[$j] eq "album")
					{
						if(length($arr[$i][2]) < $maxalbum)
						{
							for(my $j=0; $j < ($maxalbum-length($arr[$i][2])); $j++)
							{print " ";}
							print "$arr[$i][2] | \n";
						}
						else {print "$arr[$i][2] | \n";}
					}
					if($kol[$j] eq "track")
					{
						if(length($arr[$i][3]) < $maxtrek)
						{
							for(my $j=0; $j < ($maxtrek-length($arr[$i][3])); $j++)
							{print " ";}
							print "$arr[$i][3] | \n";
						}
						else {print "$arr[$i][3] | \n";}
					}
					if($kol[$j] eq "format")
					{
						print "$arr[$i][4] | \n";
					}
				}
				else
				{
					if($kol[$j] eq "band")
					{
						if(length($arr[$i][0]) < $maxgroup)
						{
							for(my $j=0; $j < ($maxgroup-length($arr[$i][0])); $j++)
							{print " ";}
							print "$arr[$i][0] | ";
						}
						else {print "$arr[$i][0] | ";}
					}
					if($kol[$j] eq "year")
					{
						print "$arr[$i][1] | ";
					}
					if($kol[$j] eq "album")
					{
						if(length($arr[$i][2]) < $maxalbum)
						{
							for(my $j=0; $j < ($maxalbum-length($arr[$i][2])); $j++)
							{print " ";}
							print "$arr[$i][2] | ";
						}
						else {print "$arr[$i][2] | ";}
					}
					if($kol[$j] eq "track")
					{
						if(length($arr[$i][3]) < $maxtrek)
						{
							for(my $j=0; $j < ($maxtrek-length($arr[$i][3])); $j++)
							{print " ";}
							print "$arr[$i][3] | ";
						}
						else {print "$arr[$i][3] | ";}
					}
					if($kol[$j] eq "format")
					{
						print "$arr[$i][4] | ";
					}
				}
				if($j == $#kol)
				{
					if($in == $dl)
					{
						if($kol[$j] eq "band")
						{
							for (my $k=0; ($k < $maxgroup+2); $k++)	{$stroka = $stroka."-";}
							$stroka = $stroka."/\n";
						}						
						if($kol[$j] eq "year")
						{
							$stroka = $stroka."------/\n";
						}
						if($kol[$j] eq "album")
						{
							for (my $k=0; ($k< $maxalbum+2); $k++)	{$stroka = $stroka."-";}
							$stroka = $stroka."/\n";
						}
						if($kol[$j] eq "track")
						{
							for (my $k=0; ($k< $maxtrek+2); $k++)	{$stroka = $stroka."-";}
							$stroka = $stroka."/\n";
						}
						if($kol[$j] eq "format")
						{
							$stroka = $stroka."-----/\n";
						}
						$ind = 0;
					}
					else
					{
						if($kol[$j] eq "band")
						{
							for (my $k=0; ($k < $maxgroup+2); $k++)	{$stroka = $stroka."-";}
							$stroka = $stroka."|";
						}						
						if($kol[$j] eq "year")
						{
							$stroka = $stroka."------|";
						}
						if($kol[$j] eq "album")
						{
							for (my $k=0; ($k< $maxalbum+2); $k++)	{$stroka = $stroka."-";}
							$stroka = $stroka."|";
						}
						if($kol[$j] eq "track")
						{
							for (my $k=0; ($k< $maxtrek+2); $k++)	{$stroka = $stroka."-";}
							$stroka = $stroka."|";
						}
						if($kol[$j] eq "format")
						{
							$stroka = $stroka."-----|";
						}
					}
				}
				else
				{
					if($kol[$j] eq "band")
					{
						for (my $k=0; ($k < $maxgroup+2); $k++)	{$stroka = $stroka."-";}
						$stroka = $stroka."+";
					}						
					if($kol[$j] eq "year")
					{
						$stroka = $stroka."------+";
					}
					if($kol[$j] eq "album")
					{
						for (my $k=0; ($k< $maxalbum+2); $k++)	{$stroka = $stroka."-";}
						$stroka = $stroka."+";
					}
					if($kol[$j] eq "track")
					{
						for (my $k=0; ($k< $maxtrek+2); $k++)	{$stroka = $stroka."-";}
						$stroka = $stroka."+";
					}
					if($kol[$j] eq "format")
					{
						$stroka = $stroka."-----+";
					}
				}
				if($j == $#kol) {print "$stroka\n";}
			}
		}
		else {};
	}
}


return 1;
END{}

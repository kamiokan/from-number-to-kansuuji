use strict;
use warnings;
use utf8;
use Encode qw(encode);
use feature qw(say);

=pod
USAGE: perl run.pl address.txt > result.txt
=cut

my $filename = $ARGV[0];
my $fh       = open_file($filename);

my @results;
while ( my $line = <$fh> ) {
    chomp($line);
    $line =~ s/−/ー/;
    $line = zenkaku2hankaku_suuji($line);
    $line = hankaku_suuji2kansuuji($line);

    push @results, $line;
}

close($fh);

foreach my $text (@results) {
    say encode( 'cp932', $text );
}

# ファイルハンドルをオープンするサブルーチン
sub open_file {
    my $filename = shift;
    open my $fh, '<:utf8', $filename
      or die "Couldn't open $filename : $!";
    return $fh;
}

# 全角数字を半角数字に変換するサブルーチン
sub zenkaku2hankaku_suuji {
    my $arg = shift;
    $arg =~ s/０/0/g;
    $arg =~ s/１/1/g;
    $arg =~ s/２/2/g;
    $arg =~ s/３/3/g;
    $arg =~ s/４/4/g;
    $arg =~ s/５/5/g;
    $arg =~ s/６/6/g;
    $arg =~ s/７/7/g;
    $arg =~ s/８/8/g;
    $arg =~ s/９/9/g;
    return $arg;
}

# 半角数字を漢数字に変換するサブルーチン
sub hankaku_suuji2kansuuji {
    my $arg = shift;
    $arg =~ s/0/０/g;
    $arg =~ s/1/一/g;
    $arg =~ s/2/二/g;
    $arg =~ s/3/三/g;
    $arg =~ s/4/四/g;
    $arg =~ s/5/五/g;
    $arg =~ s/6/六/g;
    $arg =~ s/7/七/g;
    $arg =~ s/8/八/g;
    $arg =~ s/9/九/g;
    return $arg;
}

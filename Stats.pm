package Stats;

use strict;
use Exporter;
use POSIX;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
$VERSION = 0.1;
@ISA = qw(Exporter);
@EXPORT = ();
@EXPORT_OK = qw();
%EXPORT_TAGS = (DEFAULT => [qw()],
				ALL =>[qw()]);



sub bonferroni_correct{


my $p_val =shift;
my $instances = shift;

my $corr = $p_val * $instances;

$corr = 1 if $corr > 1;

return $corr;


}

sub hypergeometric {
    my $n = $_[0];
    my $p = $_[1];
    my $k = $_[2];
    my $r = $_[3];
    my $q;
    my $np;
    my $nq;
    my $top;
    
    $q = (1-$p);
    
    $np = floor( $n*$p + 0.5 );  # round to nearest int
    $nq = floor( $n*$q + 0.5 );

    my $log_n_choose_k = &lNchooseK( $n, $k );

    $top = $k;
    if ( $np < $k ) {
	$top = $np;
    }

    my $lfoo = &lNchooseK($np, $top) + &lNchooseK($n*(1-$p), $k-$top);
    my $sum = 0;

    for (my $i = $top; $i >= $r; $i-- ) {
	$sum = $sum + exp($lfoo - $log_n_choose_k);

	if ( $i > $r) {
	    $lfoo = $lfoo + log($i / ($np-$i+1)) +  log( ($nq - $k + $i) / ($k-$i+1)  )  ;
	}
    }
    return $sum;
}

# ln factorial subroutine
sub lFactorial {
    my $returnValue = 0;
    my $number = $_[0];
    for(my $i = 2; $i <= $number; $i++) {
     	$returnValue = $returnValue + log($i);
    }
    return $returnValue;
}

# ln N choose K subroutine
sub lNchooseK {
    my $n = $_[0];
    my $k = $_[1];
    my $answer = 0;

    if( $k > ($n-$k) ){
	$k = ($n-$k);
    }

    for( my $i=$n; $i>($n-$k); $i-- ) {
	$answer = $answer + log($i);
    }

    $answer = $answer - &lFactorial($k);
    return $answer;
}





1;

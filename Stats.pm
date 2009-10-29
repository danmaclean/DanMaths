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
# Hypergeometric tail probability
#
# Returns one-tailed probability based on the hypergeometric distribution:
# the probability of witnessing r successes in a sample of k items from
# a pool of size n, with r having prob (proportion) p, sampling without
# replacement. Uses natural log n choose k and factorial subroutines.
    my $n = $_[0]; #population_size
    my $p = $_[1]; #proportion
    my $k = $_[2]; #sample
    my $r = $_[3]; #successes
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

=head1 NAME

Stats - a module of frequently used statistical methods 

=head1 AUTHOR

Dan MacLean (dan.maclean@tsl.ac.uk)

=head1 SYNOPSIS

	use DanMaths::Stats;
	my $population_size = 2410;
	my $proportion_successes_in_population = 0.4;
	my $attempts = '341';
	my $succeses = '291';
	my $p = Stats::hypergeometric($population_size,$proportion_successes_in_population,$attempts,$succeses);

=head1 DESCRIPTION

The Stats module contains routines for carrying out some frequently used statistical tests that are not implemented elsewhere.
The module does not create objects like some of the other modules, rather its methods are accessed in the manner of subroutines in external files.

=head1 METHODS

=over

=item hypergeometric(n,p,k,r)

Returns one-tailed probability based on the hypergeometric distribution: the probability of witnessing r successes in a sample
of k items from a pool of size n, with r having prob (proportion) p, sampling without replacement.

	my $population_size = 2410;
	my $proportion_successes_in_population = 0.4;
	my $attempts = '341';
	my $succeses = '291';
	my $p = Stats::hypergeometric($population_size,$proportion_successes_in_population,$attempts,$succeses);

=item bonferroni_correct(p_val, number_of_repeats);

Returns a bonferroni_corrected p value for the provided p value based on the number of times the test was repeated

	my $p_value = 0.01;
	my $number_of_repeats = 145;
	my $bonferroni = Stats::bonferroni_correct($p_value, $number_of_repeats);

=back


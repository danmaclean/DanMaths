package Evaluations;

use strict;
use Exporter;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
$VERSION = 0.1;
@ISA = qw(Exporter);
@EXPORT = ();
@EXPORT_OK = qw();
%EXPORT_TAGS = (DEFAULT => [qw()],
				ALL =>[qw()]);


sub sens_and_spec{

my $fn = shift;
my $tn = shift;
my $fp = shift;
my $tp = shift;


	my $sens = $tp / ($tp + $fn);
	my $spec = $tn / ($tn + $fp);

	return ($sens, $spec);


}


1;

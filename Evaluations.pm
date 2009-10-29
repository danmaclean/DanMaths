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

=head1 NAME

Evaluations - a module of numeric evaluation methods 

=head1 AUTHOR

Dan MacLean (dan.maclean@tsl.ac.uk)

=head1 SYNOPSIS

	use DanMaths::Evaluations;
	my $false_negatives = 2410;
	my $true_negatives = 32140;
	my $false_positives = '341';
	my $true_positives = '291';
	my ($sensitivity, $specificity) = Evaluations::sens_and_spec($false_negatives, $true_negatives, $false_positives, $true_positives);

=head1 DESCRIPTION

The Evaluations module contains routines for carrying out Evaluations such as sensitivity and specificity.
The module does not create objects like some of the other modules, rather its methods are accessed in the manner of subroutines in external files.

=head1 METHODS

=over

=item sens_and_spec(fn,tn,fp,tp)

Returns the sensitivity and specificity (on a scale of 0 -> 1) for pre-calculated values

	my $false_negatives = 2410;
	my $true_negatives = 32140;
	my $false_positives = '341';
	my $true_positives = '291';
	my ($sensitivity, $specificity) = Evaluations::sens_and_spec($false_negatives, $true_negatives, $false_positives, $true_positives);




=back

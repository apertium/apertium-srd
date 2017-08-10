#!/usr/bin/perl

use strict;
use utf8;

my $L_TRACE = 0;	# Trace a partir de la línia indicada del fitxer d'entrada (si no és 0)

binmode(STDIN, ":encoding(UTF-8)");
binmode(STDOUT, ":encoding(UTF-8)");
binmode(STDERR, ":encoding(UTF-8)");

my $linia;
my $falta_analisi_ant = 0;

while (tractar_element()) {
	;
}

exit 0;

sub tractar_element {
	# inici element
	while ($linia !~ m|^"<|o) {
		print "Error 001 en l. $.: espai o tabulador en inici de línia\n" if $linia =~ m|^\s|o && $linia !~ m|^\s"+\s*$|o;
		print "Error 002 en l. $.: ; en inici de línia\n" if $linia =~ m|^;|o;
		$linia = <STDIN>;
		chop $linia;
	}
	my $element = $linia;
	my $n_linia = $.;

	# resseguim les anàlisis
	my @analisis = ();
	my @n_linies = ();
	my $falta_analisi = 1;
	$linia = <STDIN>;
	chop $linia;
	while (($linia =~ m|^\s|o || $linia =~ m|^;|o) && $linia !~ m|^\s\-\s*$|o && $linia !~ m|^\s"+\s*$|o) {
print "$.. linia=<$linia>\n" if $L_TRACE && $. >= $L_TRACE;
		if ($linia =~ m|^\s+|o) {
print "$.. 1\n" if $L_TRACE && $. >= $L_TRACE;
			# verificació de la línia
			if ($linia =~ m|^\s+$|o) {
				# a vegades hi ha línies en blanc, ves a saber per què
			} elsif ($linia =~ m|^\s+"[^"]*"\s*$|o) {
				print "Error 120 en l. $.: falta anàlisi per a $linia\n";
			} elsif ($linia =~ m|^\s+"[^"]*" n\s*$|o) {
				print "Error 121 en l. $.: anàlisi parcial per a $linia\n";
			} elsif ($linia =~ m|^\s+"[^"]*" n ([a-z]*) ([a-z]*)$|o) {
print "$.. 1.3\n" if $L_TRACE && $. >= $L_TRACE;
				my $gen = $1;
				my $nbr = $2;
				if (($gen ne 'm' && $gen ne 'f' && $gen ne 'mf') || ($nbr ne 'sg' && $nbr ne 'pl' && $nbr ne 'sp')) {
					print "Error 122 en l. $.: anàlisi parcial per a $linia (gen = $gen, nbr = $nbr)\n"
				} else {
					push @analisis, $linia;
					push @n_linies, $.;
				}
			} elsif ($linia =~ m|^\s+"[^"]*" adj\s*$|o) {
				print "Error 123 en l. $.: anàlisi parcial per a $linia\n";
			} elsif ($linia =~ m|^\s+"[^"]*" adj ([a-z]*) ([a-z]*)$|o) {
				my $gen = $1;
				my $nbr = $2;
				if (($gen ne 'm' && $gen ne 'f' && $gen ne 'mf') || ($nbr ne 'sg' && $nbr ne 'pl' && $nbr ne 'sp')) {
					print "Error 124 en l. $.: anàlisi parcial per a $linia (gen = $gen, nbr = $nbr)\n"
				} else {
					push @analisis, $linia;
					push @n_linies, $.;
				}
			} else {
print "$.. 1.6\n" if $L_TRACE && $. >= $L_TRACE;
				push @analisis, $linia;
				push @n_linies, $.;
			}
		} else {	# $linia =~ m|^;|o
print "$.. 2\n" if $L_TRACE && $. >= $L_TRACE;
			$falta_analisi = 0;
		}
		$linia = <STDIN>;
		chop $linia;
	}
	if ($#analisis == 0) {
		$falta_analisi_ant = 0;
		return 1;
	} elsif ($#analisis == -1) {
		print "Error 101 en l. $n_linia: falta anàlisi per a $element\n";
#exit 0;
		if ($falta_analisi_ant) {
			print "Fi de la anàlisi en l. $. (1)\n";
			return 0;
		}
		$falta_analisi_ant = 1;
	} else {	# $#analisis > 0
		printf "Error 110 en l. $n_linia: %d anàlisis per a $element\n", $#analisis + 1;
		if ($falta_analisi && $falta_analisi_ant) {
			print "Fi de la anàlisi en l. $. (2)\n";
			return 0;
		}
		$falta_analisi_ant = 1;
	}
}

#!/opt/local/bin/perl -w
###
# Run "port mirror" for all Portfiles changed in a given revision
# Created by William Siegrist,
# e-mail: wsiegrist@apple.com
# $Id$
###

use strict;
use Mail::Sendmail;

my $REPOPATH = "/svn/repositories/macports/";
my $REPOHOST = "http://svn.macosforge.org/repository/macports";
my $SVNLOOK = "/opt/local/bin/svnlook";
my $PORTCMD = "/opt/local/bin/port";
my $SVN = "/opt/local/bin/svn -q --non-interactive";
my $MKDIR = "/bin/mkdir -p";

my $rev = $ARGV[0] or usage();
my $TMPROOT = "/tmp/mp_mirror/$rev";

my @changes = `$SVNLOOK changed $REPOPATH -r $rev`;

foreach my $change (@changes) {
    if ($change =~ /Portfile/) { 
	# remove svn status and whitespace
	chop($change);
	$change =~ s/\w\s+([\/\w]+)/$1/g; 
	# extract the portname from parent dir of Portfile
	my $port = $change;
	$port =~ s/^.*\/([^\/]+)\/Portfile$/$1/g;

	# get the group directory
	my $group = $change;
	$group =~ s/^.*\/([^\/]+)\/[^\/]+\/Portfile$/$1/g;	

	# make a temporary work area
	`$MKDIR $TMPROOT/$group/$port`;
	chdir("$TMPROOT/$group/$port") or die("Failed to change dir for port: $port");	
	`$SVN co $REPOHOST/trunk/dports/$group/$port/ .`;
	
	_mirror($port);
    }
}


#
# Subroutines
#

sub _mirror {
    my ($port) = @_; 
    my $errors = `sudo $PORTCMD -qc mirror`;

    if ($errors) {
	my $maintainers = `$PORTCMD -q info --maintainer $port`;
	# strip everything but the email addresses
	$maintainers =~ s/maintainer: //;
	$maintainers =~ s/openmaintainer\@macports.org//;
	$maintainers =~ s/nomaintainer\@macports.org//;
	chop($maintainers);

	_mail($port, $maintainers, $errors);
    }
}

sub _mail {
    my ($port, $maintainers, $errors) = @_;

    my %mail = (
             To => $maintainers,
             From => 'noreply@macports.org',
             Subject => "[MacPorts Mirror] Portfile Mirror Errors for: $port",
             Message => "Portfile: $port \n\n\n Errors: $errors \n\n",
             smtp => 'relay.apple.com',
             );

    sendmail(%mail) or die $Mail::Sendmail::error;
}

sub usage {
	print "usage: portfile_mirror.pl <rev>\n";
	exit();
}





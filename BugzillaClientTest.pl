#!/usr/bin/perl

use BugzillaClient;
use strict;

$BugzillaClient::bzDebug = 0;

#login to suse bugzilla:
my $jar = BugzillaClient::bzConnect( 'digitaltomm','' );

#login to another bugzilla
#$SUSE::BugzillaClient::bzBaseUrl = "http://bugs.otrs.org/";
#my $jar = SUSE::BugzillaClient::bzConnect( 'user','pwd' );

# Example for fetching a single Bug for a provided Bugid: 
my $bug = BugzillaClient::getBug($jar, 507548);
print "Bugs short Desc: " . $bug->{short_desc} . "\n";


# Example fetching an Array of Bugs for the provided Query
# (Copy the Query URL from your Browser)

print "Querying list of Bugs: \n";
my $query = "https://bugzilla.suse.com/buglist.cgi?query_format=advanced&product=openSUSE.org&bug_status=NEEDINFO";

my @bugs = BugzillaClient::getBugs($jar, $query);

foreach my $bug (@bugs){
        print $bug->{bug_id} . ": " . $bug->{short_desc} . "\n";
}


# Example fetching an Array of Bugs for the provided Query
# (Copy the Query URL from your Browser and add &ctype=csv)
# Fetching by CSV is much faster, but does not contain all the fields as getBugs()

print "Getting Bugs by parsing CSV: \n";
my $query = "https://bugzilla.suse.com/buglist.cgi?query_format=advanced&product=openSUSE+10.3&bug_status=NEEDINFO&ctype=csv";

my @bugs = BugzillaClient::getBugsCSV($jar, $query);

foreach my $bug (@bugs){
        print $bug->{bug_id} . ": " . $bug->{short_desc} . "\n";
}


print "OK\n";
